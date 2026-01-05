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

  zero = Btree::Node.new(0)

  it "insert" do
    root.left = zero
    root.left.try(&.value).should eq 0
  end

  it "delete" do
    root.left = left
    root.left.try(&.value).should eq 2
  end

  it "level_order" do
    root.level_order.should eq [1, 2, 3, 4, 5, 6, 7]
    left.level_order.should eq [2, 4, 5]
    right.level_order.should eq [3, 6, 7]
  end

  it "pre_order" do
    root.pre_order.should eq [1, 2, 4, 5, 3, 6, 7]
    left.pre_order.should eq [2, 4, 5]
  end

  it "in_order" do
    left2, _, _ = Btree::Node[4, 2, 6]
    right2, _, _ = Btree::Node[12, 10, 14]
    root2 = Btree::Node.new(8, left2, right2)

    # left2.in_order.should eq [2, 4, 6]
    root2.in_order.should eq [2, 4, 6, 8, 10, 12, 14]
  end

  it "post_order" do
    root.post_order.should eq [4, 5, 2, 6, 7, 3, 1]
    left.post_order.should eq [4, 5, 2]
  end
end
