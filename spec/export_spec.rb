require 'fn_space/export'

describe FnSpace::Export do
  it 'exports to a constant' do
    FnSpace::Export.('Foo', 15)
    expect(Foo).to eql(15)
  end

  it 'exports to a child constant' do
    FnSpace::Export.('FnSpace::Bar', 63)
    expect(FnSpace::Bar).to eql(63)
  end

  it 'exports to a symbol constant' do
    FnSpace::Export.(:Fizz, 911)
    expect(Fizz).to eql(911)
  end
end
