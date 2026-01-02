module Btree
  class Node(T)
    property value : T
    property left : self?
    property right : self?

    def self.[](parent, left, right)
      left_node = new(left)
      right_node = new(right)
      parent_node = new(parent, left_node, right_node)

      {parent_node, left_node, right_node}
    end

    def initialize(@value, @left = nil, @right = nil)
    end
  end
end
