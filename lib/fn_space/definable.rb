module FnSpace
  module Definable
    def define(name, &b)
      define_method(name, &b)
      self
    end
  end
end
