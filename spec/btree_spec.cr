require "./spec_helper"

describe Btree do
  zuo, _, _ = Btree::Node[2, 4, 5]
  you, _, _ = Btree::Node[3, 6, 7]
  gen = Btree::Node.new(1, zuo, you)

  it "new" do
    gen.shu.should eq 1
    gen.zuo.try(&.shu).should eq 2
    gen.you.try(&.shu).should eq 3
  end
end
