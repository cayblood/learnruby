require 'wondrous'

describe "Wondrous Numbers" do
  describe "#next_in_sequence" do
    it "even numbers are divided by 2" do
      next_in_sequence(4).should == 2
      next_in_sequence(10).should == 5
    end

    it "odd numbers are tripled and incremented" do
      next_in_sequence(5).should == 16
      next_in_sequence(3).should == 10
    end
  end

  describe "#wondrous?" do
    it "is true" do
      wondrous?(5).should be_true
      wondrous?(123).should be_true
    end
  end
end
