class Presentation

  attr_accessor :topic, :author, :scores

  def initialize topic, author
    @topic = topic
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