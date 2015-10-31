FnSpace::Export = ->(const, obj) do
  parent, _, child = const.to_s.rpartition('::')
  parent = parent.empty? ? Object : Object.const_get(parent)
  parent.const_set(child, obj)
end
