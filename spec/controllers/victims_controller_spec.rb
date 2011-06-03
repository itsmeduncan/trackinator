require 'spec_helper'

describe VictimsController do
  
  describe "#index" do
    it "should response successfully" do
      get :index
      response.should be_success
    end
    
    it "should get all of the victims" do
      Victim.should_receive(:all).with(:include => :visits).once.and_return([])
      get :index
    end
  end

  describe "#show" do
    it "should find the Victim" do
      victim = Factory(:victim)
      Victim.should_receive(:find_by_slug).with(victim.slug, :include => :visits).and_return(victim)
      
      get :show, :id => victim.slug
      
      assigns(:victim).should == victim
      response.should be_success
    end
  end
  
end
