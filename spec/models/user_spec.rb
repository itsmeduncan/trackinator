require 'spec_helper'

describe User do

  it "should make a user" do
    Factory(:user).should be_valid
    Factory.build(:user).should be_valid
  end

end
