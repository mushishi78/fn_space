require 'fn_space/definable'

describe FnSpace::Definable do
  it 'can assign methods in a chain' do
    tortoise = Class.new
      .extend(FnSpace::Definable)
      .define(:initialize) { |x, y| @x = x; @y = y }
      .define(:forward) { tortoise.(@x, @y + 1) }
      .define(:right) { tortoise.(@x + 1, @y) }
      .define(:pos) { [@x, @y] }
      .method(:new)

    jeff = tortoise.(0, 0).forward.right.right
    expect(jeff.pos).to eql([2, 1])
  end
end
