require("../lab03/pres")

class Vote

  def initialize
    @pres = {}

    File.open("presentations.txt").each do |line|
      num, title, author, cat = line.split(/:/)
      @pres[num.to_i] = Pres.new title, author, cat
    end
    
    File.open("votes.txt").each do |line|
      num, vote = line.split.collect{ |e| e.to_i }
      @pres[num].add_score(vote)
    end

#    @pres.each do |k, p|
#      puts p.average_score
#    end

     sorted = @pres.sort_by { |k, v| v.average_score }.reverse
    
    (0...3).each { |i| puts sorted[i][1].average_score }
    
#    puts sorted[0]
    
#    keys = sorted.keys.slice(0, 3)
#    puts keys

  end

end