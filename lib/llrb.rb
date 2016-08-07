class LLRB
  RED = true
  BLACK = false

  attr_reader :root

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
    while node
      node = node.left
    end

    node ? node.key : nil
  end

  def put(key, value)
    @root = insert(root, key, value)
  end

  private

  def compare(key, other)
    return 0 if key == other
    return 1 if key > other
    -1
  end

  def insert(node, key, value)
    return Node.new(key, value, RED) unless node

    case compare(key, node.key)
    when 0
      node.value = value
    when -1
      node.left = insert(node.left, key, value)
    when 1
      node.right = insert(node.right, key, value)
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
  end
end
