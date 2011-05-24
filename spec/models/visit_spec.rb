require 'spec_helper'

describe Visit do
  describe "#validations" do
    it "should be able to generate a valid Visit" do
      Factory(:visit).should be_valid
      Factory.build(:visit).should be_valid
    end
  end
  
  describe "Visit#successful" do
    it "should not return unsuccessful Visits" do
      Factory(:visit, :status => 500)
      Visit.successful.all.should be_empty
    end

    it "should return only successful Visits" do
      Factory(:visit, :status => 200)
      Visit.successful.all.should_not be_empty
    end
  end
end
