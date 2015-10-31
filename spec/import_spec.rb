require 'fn_space/utils'
require 'fn_space/import'

describe FnSpace::Import do
  let(:source) do
    Module.new do
      def self.q; 46 end
      def self.w; 68 end
      def self.t; 99 end
    end
  end

  it 'imports properties from an object' do
    expect(FnSpace::Import.(:t, :q).from(source)).to eql([99, 46])
  end

  it 'imports methods as method objects' do
    w, t = FnSpace::Import.methods.(:w, :t).from source
    expect(w.()).to eql(68)
    expect(t.()).to eql(99)
  end
end
