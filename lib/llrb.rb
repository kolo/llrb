class LLRB
  RED = true
  BLACK = false

  attr_reader :root

  def put(key, &blk)
    @root = insert(root, key, &blk)
  end

  def find(key)
    node = root
    while node
      case compare(key, node.key)
      when 0 
        return node.value
      when -1
        node = node.left
      when 1
        node = node.right
      end
    end

    return nil
  end

  def min
    node = root
    while true
      break unless node.left
      node = node.left
    end

    node ? node.key : nil
  end

  def max
    node = root
    while true
      break unless node.right
      node = node.right
    end

    node ? node.key : nil
  end

  def each
    return enum_for(:each) unless block_given?

    ary = []
    node = root
    while ary.any? || node
      if node
        ary.push(node)
        node = node.left
      else
        node = ary.pop
        yield [node.key, node.value]
        node = node.right
      end
    end
  end

  private

  def compare(key, other)
    key <=> other
  end

  def insert(node, key, &blk)
    return Node.new(key, yield(nil), RED) unless node

    case compare(key, node.key)
    when 0
      node.value = yield(node.value)
    when -1
      node.left = insert(node.left, key, &blk)
    when 1
      node.right = insert(node.right, key, &blk)
    end

    node = node.rotate_left if red?(node.right)
    node = node.rotate_right if red?(node.left) && red?(node.left.left)
    node.flip_color if red?(node.left) && red?(node.right)
   
    return node
  end

  def red?(node)
    return false unless node
    node.color == RED
  end

  class Node
    attr_accessor :color, :key, :value, :left, :right

    def initialize(key, value, color)
      @key = key
      @value = value
      @color = color
    end

    def rotate_left
      node = right

      @right = node.left
      node.left = self

      node.color = node.left.color
      node.left.color = RED

      node
    end

    def rotate_right
      node = left

      @left = node.right
      node.right = self

      node.color = node.right.color
      node.right.color = RED

      node
    end

    def flip_color
      @color = !self.color
      left.color = !left.color
      right.color = !right.color

      self
    end

    def to_s
      "[key: %d, values: %d, color: %s, left: %s, right: %s]" % [key, value.size, color, left.to_s, right.to_s]
    end
  end
end
