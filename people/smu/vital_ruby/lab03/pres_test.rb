require "./pres"
require "test/unit"

class PresTest < Test::Unit::TestCase

  def test_average
    p = Pres.new("How To Program in Ruby", "Ruby Hacker")
    p.add_score(5)
    p.add_score(4)
    p.average_score
    assert_equal 4.5, p.average_score
  end

  def test_illegal_value_less_than
    p = Pres.new("How To Program in Ruby", "Ruby Hacker")
    assert_raise StandardError do
      p.add_score(-1)
    end
  end

  def test_illegal_value_more_than
    p = Pres.new("How To Program in Ruby", "Ruby Hacker")
    assert_raise StandardError do
      p.add_score(6)
    end
  end

end
