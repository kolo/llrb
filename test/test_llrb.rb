# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/llrb'

class LLRBTest < Minitest::Test
  def test_insert
    assert_equal 4, tree.root.value
  end

  def test_min
    assert_equal 'a', tree.min
  end

  def test_max
    assert_equal 'g', tree.max
  end

  def test_each
    assert_equal Enumerator, tree.each.class
    assert_equal 28, tree.each.inject(0) { |sum, (_, value)| sum + value }
  end

  private

  def tree
    @tree ||= LLRB.new.tap do |tree|
      tree.put('a') { 1 }
      tree.put('b') { 2 }
      tree.put('c') { 3 }
      tree.put('d') { 4 }
      tree.put('e') { 5 }
      tree.put('f') { 6 }
      tree.put('g') { 7 }
    end
  end
end
