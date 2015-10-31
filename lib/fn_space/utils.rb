require_relative 'assignable'

mod = ->(&b) { Module.new(&b).extend(FnSpace::Assignable) }
struct = ->(hash) { hash.reduce(mod.()) { |obj, (k, v)| obj.assign(k){v} } }
apply_send = ->(method, *args) { ->(obj) { obj.send(method, *args) } }

chain = ->(value) do
  monad = mod.()
    .assign(:>>) { |fn| value = fn.to_proc.(value); monad }
    .assign(:<<) { |fn| fn.to_proc.(value); monad }
    .assign(:|) { |fn| fn.to_proc.(monad) }
    .assign(:value) { value }
end

FnSpace::Utils = struct.(mod: mod, struct: struct, apply_send: apply_send, chain: chain)
