module FnSpace
  module Assignable
    def assign(name, &b)
      define_singleton_method(name, &b)
      self
    end
  end
end
