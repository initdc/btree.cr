module Btree
  class Node(T)
    property shu : T
    property zuo : self?
    property you : self?

    def self.[](gen, zuo, you)
      zuo_node = new(zuo)
      you_node = new(you)
      gen_node = new(gen, zuo_node, you_node)

      {gen_node, zuo_node, you_node}
    end

    def initialize(@shu, @zuo = nil, @you = nil)
    end
  end
end
