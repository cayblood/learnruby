require 'spec_helper'
require 'presentation'

describe Presentation do
  let(:presentation) { Presentation.new("TITLE", "PRESENTER") }

  it "has a title and presenter" do
    presentation.title.should == "TITLE"
    presentation.presenter.should == "PRESENTER"
  end

  it "can have scores added to it" do
    lambda { presentation.add_score(4) }.should_not raise_error
  end

  it "can calculate the average score with a single score" do
    presentation.add_score(4)
    presentation.average_score.should == 4
  end

  it "can calculate the average of two scores" do
    presentation.add_score(4)
    presentation.add_score(5)
    presentation.average_score.should be_within(0.001).of(4.5)
  end

  it "rejects too large scores with an error" do
    lambda {
      presentation.add_score(6)
    }.should raise_error(InvalidScoreError)
  end

  it "rejects too small scores with an error" do
    lambda {
      presentation.add_score(0)
    }.should raise_error(InvalidScoreError)
  end
end
