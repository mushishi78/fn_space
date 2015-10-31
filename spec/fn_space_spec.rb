require 'fn_space'

describe 'fn_space' do
  it 'imports and exports' do
    fn_space(:Formula) do |import, exports|
      pi = 3.14
      exports.circ = ->(r) { 2 * pi * r }
      exports.area = ->(r) { pi * r ** 2 }
    end

    res1 = 0
    res2 = 0

    fn_space do |import|
      fn1, fn2 = import.(:area, :circ).from Formula
      res1 = fn1.(8)
      res2 = fn2.(8)
    end

    expect(res1).to eql(200.96)
    expect(res2).to eql(50.24)
  end
end
