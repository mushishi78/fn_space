require 'ostruct'
require_relative 'fn_space/utils'
require_relative 'fn_space/import'
require_relative 'fn_space/export'

def fn_space(const = nil, &b)
  exports = OpenStruct.new
  Module.new.instance_exec(FnSpace::Import, exports, &b)
  FnSpace::Export.(const, FnSpace::Utils.struct.(exports.to_h)) if const
end
