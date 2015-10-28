class FnSpace < BasicObject
  def self.import(*names)
    Importer.new(names)
  end

  def self.export(obj)
    Exporter.new(obj)
  end

  class Importer
    def initialize(names)
      @names = names
    end

    def from(constant)
      obj = ::Object.const_get(constant)
      is_hash = obj.respond_to?(:has_key?)
      functions = @names.map { |m| is_hash ? obj[m].to_proc : obj.method(m) }
      functions.length == 1 ? functions.first : functions
    end
  end

  class Exporter
    def initialize(obj)
      @obj = obj
    end

    def to(constant)
      if ::Object.const_defined?(constant)
        ::Object.const_get(constant).merge!(@functions)
      else
        ::Object.const_set(constant, @functions)
      end
    end
  end
end
