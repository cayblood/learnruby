require("./presentation")

class Vote

  attr_accessor :presentations, :votes

  def initialize
    @votes = []
    @presentations = {}
    
    read_presentations
    read_votes
  end
  
  def read_presentations
    open("presentations.txt").each do |line|
      num, title, author = line.split(/:/)
      @presentations[num.to_i] = Presentation.new title, author
    end
  end

  def read_votes
    open("votes.txt").each do |line|
      @votes << (num, vote = line.split.collect{ |e| e.to_i })
      @presentations[num].add_score(vote)
    end
  end

  def get_above_4
    @presentations.values.select { |v| v.average_score >= 4 }
  end

  def get_below_2
    @presentations.values.select { |v| v.average_score <= 2 }
  end

end