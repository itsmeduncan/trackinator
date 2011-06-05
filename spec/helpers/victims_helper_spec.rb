require 'spec_helper'

describe VictimsHelper do
  describe "#victim_types" do
    it "should give back an array of tuples with the valid types" do
      helper.victim_types.map(&:second).flatten.sort.should == Victim::VALID_TYPES.sort
    end

    it "should titalize all the types properly for display" do
      helper.victim_types.map(&:first).flatten.sort.should == Victim::VALID_TYPES.map(&:titleize).sort
    end
  end
end