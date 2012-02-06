class Pres

  attr_accessor :what, :who

  def initialize what, who
    @what = what
    @who = who

    @scores = []
  end

  def add_score score
    @scores << score
  end

  def average_score
    @scores.reduce(:+).to_f / @scores.size
  end

end