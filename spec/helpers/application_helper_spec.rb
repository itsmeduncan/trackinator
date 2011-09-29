require 'spec_helper'

describe ApplicationHelper do
  describe "#pretty_time" do
    it "should format the datetime correctly" do
      datetime = DateTime.parse("January 1st, 2011 19:00")
      helper.pretty_time(datetime).should == "01/01/11 19:00"
    end

    it "shouldn't blow up when given something wrong" do
      helper.pretty_time(nil).should == ""
      helper.pretty_time(:foo).should == ""
    end
  end
end
