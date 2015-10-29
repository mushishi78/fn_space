require_relative 'fn_space'

class FnSpace
  new = import_methods.(:new).from.('Module')

  assign = ->(obj, name, &b) { obj.define_singleton_method(name, &b); obj }
  struct = ->(hash) { hash.reduce(new.()) { |obj, (k, v)| assign.(obj, k) { v } } }
  send = ->(method, *args) { ->(obj) { obj.send(method, *args) } }

  chain = ->(value) do
    obj = new.()
    assign.(obj, :>>) { |fn| value = fn.(value); obj }
    assign.(obj, :<<) { |fn| fn.(value); obj }
    assign.(obj, :|) { |_| value }
  end

  utils = struct.(new: new, assign: assign, struct: struct, send: send, chain: chain)
  export.(utils).as.('FnSpace::Utils')
end
