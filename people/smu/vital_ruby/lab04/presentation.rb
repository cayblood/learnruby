class Presentation

  attr_accessor :title, :author, :scores

  def initialize title, author
    @title = title
    @author = author
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