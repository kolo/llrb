require "minitest/autorun"
require_relative "../lib/llrb"

class LLRBTest < Minitest::Test
  def test_insert
    tree = LLRB.new
    tree.put("a", 1)
    tree.put("b", 2)
    tree.put("c", 3)
    tree.put("d", 4)
    tree.put("e", 5)
    tree.put("f", 6)
    tree.put("g", 7)

    tree.levelorder

    assert_equal 4, tree.root.value
  end
end
