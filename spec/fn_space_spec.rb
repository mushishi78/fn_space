require 'fn_space/fn_space'
require 'ostruct'

Foo = 5
Bar = OpenStruct.new(x: 25, y: 12)

module Fizz
  def self.add(a, b)
    a + b
  end

  def self.take(a, b)
    a - b
  end
end

describe FnSpace do
  let(:obj) { OpenStruct.new(q: 46, w: 68, t: 99) }

  describe '.import' do
    it 'imports a constant' do
      expect(FnSpace.import.('Foo')).to eql(5)
    end

    it 'imports propeties from a constant' do
      expect(FnSpace.import.(:y, :x).from.('Bar')).to eql([12, 25])
    end

    it 'imports properties from an object' do
      expect(FnSpace.import.(:t, :q).from.(obj)).to eql([99, 46])
    end
  end

  describe '.import_methods' do
    it 'imports methods as method objects' do
      plus, minus = FnSpace.import_methods.(:add, :take).from.('Fizz')
      expect(plus.(3, 5)).to eql(8)
      expect(minus.(3, 5)).to eql(-2)
    end

    it 'imports properties from an object' do
      get = FnSpace.import_methods.(:[]).from.(obj)
      expect(get.(:w)).to eql(68)
    end
  end

  describe '.export' do
    it 'exports an obj as constant' do
      FnSpace.export.(55).as.('Fish')
      expect { Fish }.to_not raise_error
      expect(Fish).to eql(55)
    end

    it 'exports an obj to a child constant' do
      FnSpace.export.(79).as.('Fizz::Buzz')
      expect { Fizz::Buzz }.to_not raise_error
      expect(Fizz::Buzz).to eql(79)
    end
  end
end
