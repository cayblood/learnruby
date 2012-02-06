require 'test/unit'
require 'presentation'

class PresentationTest < Test::Unit::TestCase
  def setup
    @p = Presentation.new("TITLE", "PRESENTER", "CAT")
  end

  def test_has_title_and_presenter
    assert_equal "TITLE", @p.title
    assert_equal "PRESENTER", @p.presenter
    assert_equal "CAT", @p.category
  end

  def test_can_report_average_score_with_one_score
    @p.add_score(4)
    assert_equal 4, @p.average_score
  end

  def test_can_report_average_score_with_two_scores
    @p.add_score(4)
    @p.add_score(5)
    assert_equal 4.5, @p.average_score
  end
end
