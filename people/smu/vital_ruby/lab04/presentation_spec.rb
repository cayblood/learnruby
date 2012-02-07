require("./presentation")

describe Presentation do
  it "calculates the average" do
    p = Presentation.new("Some topic", "Some author")
    p.add_score(5)
    p.add_score(4)
    p.average_score.should eq(4.5)
  end
end

