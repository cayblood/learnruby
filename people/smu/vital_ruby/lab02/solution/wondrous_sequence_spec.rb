require "wondrous_sequence"

describe "#wondrous_sequence" do
  before do
    CACHE.clear
  end

  it "calculates the sequence for 5" do
    wondrous_sequence(5).should == [5,16,8,4,2,1]
  end

  it "uses the cached value for 5 recalculating 5's sequence" do
    CACHE[5] = [:FIVE_SEQUENCE]
    wondrous_sequence(5).should == [:FIVE_SEQUENCE]
  end

  it "uses the cached value for 5 in calculating 17's sequence" do
    CACHE[5] = [:FIVE_SEQUENCE]
    wondrous_sequence(17).should ==
      [17, 52, 26, 13, 40, 20, 10, :FIVE_SEQUENCE]
  end

  it "updates the cache when calculating 17" do
    CACHE[5] = [:FIVE_SEQUENCE]
    wondrous_sequence(17)
    CACHE[17].should == [17, 52, 26, 13, 40, 20, 10, :FIVE_SEQUENCE]
  end
end
