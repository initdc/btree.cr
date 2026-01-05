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

    def stack_pre_order
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

    def pre_order
      queue = Deque.new([self])
      result = Array(T).new

      node = queue.pop
      while node
        result << node.value

        if right = node.right
          queue << right
        end

        if left = node.left
          node = left
        else
          node = queue.pop?
        end
      end

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

    class Local(T)
      property another_way : Node(T)? = nil
      property node : Node(T)
      property has_another : Bool? = nil
      property visted_left : Bool = false
      property visted_right : Bool = false
      property right_branch : Bool

      def initialize(@node, @right_branch = false)
      end
    end

    def in_order
      expolre_map = [Local.new(self)]
      result = Array(T).new

      while local = expolre_map[0]?
        if local.visted_left && local.visted_right
          expolre_map.shift?
          next
        end

        node = local.node

        if local.has_another == nil
          if right = node.right
            local.has_another = true
            local.another_way = right
          else
            local.has_another = false
          end
        end

        if !local.visted_left
          if left = node.left
            expolre_map.unshift(Local.new(left))
            next
          else
            local.visted_left = true
            result << node.value
          end
        else
          result << node.value
        end

        if !local.visted_right
          if local.has_another
            if right = local.another_way
              expolre_map.unshift(Local.new(right, true))
              next
            end
          else
            local.visted_right = true
          end
        end

        if local.visted_left && local.visted_right
          if parent = expolre_map[1]?
            parent.visted_left = true

            if local.right_branch
              parent.visted_right = true
            end
          end

          expolre_map.shift
        end
      end

      result
    end

    def recur_in_order
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
