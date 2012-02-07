require("./vote")

describe Vote do
  
  it "should read the presentations" do
    v = Vote.new
    v.presentations.size.should eq(24)
  end

  it "should read the votes" do
    v = Vote.new
    v.votes.size.should eq(250)
  end

  it "should return votes above 4" do
    v = Vote.new
    
    v.get_above_4.size.should eq(5)
    
    v.get_above_4.each { |p| p.average_score.should >= 4 }
  end

  it "should return votes below 2" do
    v = Vote.new
    
    v.get_below_2.size.should eq(11)
    
    v.get_below_2.each { |p| p.average_score.should <= 2 }
  end
  
end

