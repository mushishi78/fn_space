require 'fn_space/assignable'

describe FnSpace::Assignable do
  it 'can assign methods in a chain' do
    obj = Module.new
      .extend(FnSpace::Assignable)
      .assign(:a){5}
      .assign(:b){12}

    expect(obj.a).to eql(5)
    expect(obj.b).to eql(12)
  end
end
