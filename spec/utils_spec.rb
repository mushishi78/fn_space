require 'fn_space/utils'

describe FnSpace::Utils do
  describe 'mod' do
    it 'creates a object with assign function' do
      res = FnSpace::Utils.mod.().assign(:q){50}.assign(:w){93}
      expect(res.q).to eql(50)
      expect(res.w).to eql(93)
    end
  end

  describe 'struct' do
    it 'creates a struct from a hash' do
      res = FnSpace::Utils.struct.(a: 57, b: 6)
      expect(res.a).to eql(57)
    end
  end

  describe 'apply_send' do
    it 'creates a lamda that sends a message with paramaters to the first argument' do
      add_five = FnSpace::Utils.apply_send.(:+, 5)
      expect(add_five.(9)).to eql(14)
    end
  end

  describe 'chain' do
    it 'creates a monad' do
      x = 5
      add_one = ->(v) { v + 1 }
      side_effect = ->(v) { x += 3 }

      res = FnSpace::Utils.chain.(4) >> add_one << side_effect | :value
      expect(res).to eql(5)
      expect(x).to eql(8)
    end
  end
end
