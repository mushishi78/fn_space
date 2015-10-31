require_relative 'utils'
chain = FnSpace::Utils.chain
mod = FnSpace::Utils.mod

first_or_all = ->(array) { array.length == 1 ? array.first : array }
map = ->(array) { ->(map_fn) { array.map(&map_fn) } }
send_map_fn = ->(obj) { ->(name) { obj.send(name) } }
method_map_fn = ->(obj) { ->(name) { obj.method(name) } }

importer = ->(names, map_fn) do
  mod.().assign(:from) do |source|
    chain.(source) >> map_fn >> map.(names) >> first_or_all | :value
  end
end

import = ->(*names) { importer.(names, send_map_fn) }
import_methods = ->(*names) { importer.(names, method_map_fn) }

FnSpace::Import = mod.()
  .assign(:call, &import)
  .assign(:methods){import_methods}
