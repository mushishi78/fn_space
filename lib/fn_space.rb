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

    def as(constant)
      ::Object.const_set(constant, @obj)
    end
  end
end
