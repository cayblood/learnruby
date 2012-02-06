require "./wondrous"
require "test/unit"
 
class WondrousTest < Test::Unit::TestCase
 
  def test_no_memoization
    w = Wondrous.new false

    assert_equal 0, w.counter

    assert_equal [1], w.wondrous(1)
    assert_equal 1, w.counter

    assert_equal [5, 16, 8, 4, 2, 1], w.wondrous(5)
    assert_equal 7, w.counter

    assert_equal [10, 5, 16, 8, 4, 2, 1], w.wondrous(10)
    assert_equal 14, w.counter
  end

  def test_memoization
    w = Wondrous.new

    assert_equal 0, w.counter

    assert_equal [1], w.wondrous(1)
    assert_equal 1, w.counter

    assert_equal [5, 16, 8, 4, 2, 1], w.wondrous(5)
    assert_equal 6, w.counter

    assert_equal [10, 5, 16, 8, 4, 2, 1], w.wondrous(10)
    assert_equal 7, w.counter
  end

end
