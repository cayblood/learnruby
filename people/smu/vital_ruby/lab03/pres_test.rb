require "./pres"
require "test/unit"

class PresTest < Test::Unit::TestCase

  def test_it
    p = Pres.new("How To Program in Ruby", "Ruby Hacker")
    p.add_score(5)
    p.add_score(4)
    p.average_score
    assert_equal 4.5, p.average_score
  end

end
