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

    def level_order
      queue = Deque.new([self])
      result = Array(T).new

      while queue.size > 0
        node = queue.shift
        result << node.value

        if left = node.left
          queue << left
        end
        if right = node.right
          queue << right
        end
      end

      result
    end

    def pre_order
      stack = Deque.new([self])
      result = Array(T).new

      while stack.size > 0
        puts
        print stack.map { |x| x.value }
        node = stack.pop
        print " -", node.value, " "
        result << node.value

        if right = node.right
          stack << right
          print " +", right.value, " "
        end
        if left = node.left
          stack << left
          print " +", left.value, " "
        end
      end
      puts

      result
    end

    def recur_pre_order
      result = Array(T).new
      internal_pre_order(result, self)
      result
    end

    private def internal_pre_order(result : Array(T), parent : Node(T)?)
      if parent.nil?
        return
      end

      result << parent.value
      internal_pre_order(result, parent.left)
      internal_pre_order(result, parent.right)
    end

    def in_order
      result = Array(T).new
      internal_in_order(result, self)
      result
    end

    private def internal_in_order(result : Array(T), parent : Node(T)?)
      if parent.nil?
        return
      end

      internal_in_order(result, parent.left)
      result << parent.value
      internal_in_order(result, parent.right)
    end

    def post_order
      result = Array(T).new
      internal_post_order(result, self)
      result
    end

    private def internal_post_order(result : Array(T), parent : Node(T)?)
      if parent.nil?
        return
      end

      internal_post_order(result, parent.left)
      internal_post_order(result, parent.right)
      result << parent.value
    end
  end
end
