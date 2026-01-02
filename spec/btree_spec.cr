require "./spec_helper"

describe Btree do
  left, _, _ = Btree::Node[2, 4, 5]
  right, _, _ = Btree::Node[3, 6, 7]
  root = Btree::Node.new(1, left, right)

  it "new" do
    root.value.should eq 1
    root.left.try(&.value).should eq 2
    root.right.try(&.value).should eq 3
  end
end
