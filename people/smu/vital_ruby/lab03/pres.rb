class Pres

  attr_accessor :what, :who

  def initialize what, who
    @what = what
    @who = who

    @scores = []
  end

  def add_score score
    if (score < 1 || score > 5)
      raise StandardError
    end
    @scores << score
  end

  def average_score
    @scores.reduce(:+).to_f / @scores.size
  end

end