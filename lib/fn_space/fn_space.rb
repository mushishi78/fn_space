class FnSpace < BasicObject
  const_defined = ::Object.method(:const_defined?)
  const_get = ::Object.method(:const_get)
  const_set = ::Object.method(:const_set)
  importer = ::Struct.new(:from)
  exporter = ::Struct.new(:as)

  is_const = ->(c) { c.respond_to?(:to_s) && c.to_s =~ /^[A-Z]/ && const_defined.(c) }
  const_to_obj = ->(const) { is_const.(const) ? const_get.(const) : const }
  first_or_all = ->(array) { array.length == 1 ? array.first : array }
  send_extractor = ->(obj) { ->(name) { obj.send(name) } }
  method_extractor = ->(obj) { ->(name) { obj.method(name) } }

  from = ->(names, extractor) do
    ->(const) { first_or_all.(names.map(&extractor.(const_to_obj.(const)))) }
  end

  import = ->(*names) do
    return const_get.(names.first) if is_const.(names.first)
    importer.new(from.(names, send_extractor))
  end

  import_methods = ->(*names) { importer.new(from.(names, method_extractor)) }

  export = ->(obj) do
    as = ->(const) do
      parent, _, child = const.to_s.rpartition('::')
      parent = parent.empty? ? ::Object : const_get.(parent)
      parent.const_set(child, obj)
    end
    exporter.new(as)
  end

  define_singleton_method(:import) { import }
  define_singleton_method(:import_methods) { import_methods }
  define_singleton_method(:export) { export }
end
