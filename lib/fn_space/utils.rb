require_relative 'assignable'
require_relative 'definable'

mod = ->(&b) { Module.new(&b).extend(FnSpace::Assignable) }
struct = ->(hash) { hash.reduce(mod.()) { |obj, (k, v)| obj.assign(k){v} } }
apply_send = ->(method, *args) { ->(obj) { obj.send(method, *args) } }

chain = Class.new
  .extend(FnSpace::Definable)
  .define(:initialize) { |value| @value = value }
  .define(:>>) { |fn| @value = fn.to_proc.(value); self }
  .define(:<<) { |fn| fn.to_proc.(value); self }
  .define(:|) { |fn| fn.to_proc.(self) }
  .define(:value) { @value }
  .method(:new)

FnSpace::Utils = struct.(mod: mod, struct: struct, apply_send: apply_send, chain: chain)
