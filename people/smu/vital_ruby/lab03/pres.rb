class Pres

  attr_accessor :what, :who, :cat, :scores

  def initialize what, who, cat = "?"
    @what = what
    @who = who
    @cat = cat

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