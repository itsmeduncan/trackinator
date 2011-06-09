require 'spec_helper'

describe VisitsController do
  
  describe "#index" do
    before do
      @user = Factory(:user)
      sign_in @user
    end
    
    it "should get the Victim" do
      victim = Factory(:victim, :user => @user)
      Victim.should_receive(:find_by_slug!).with(victim.slug).and_return(victim)
      
      get :index, :victim_id => victim.slug
      
      assigns(:victim).should == victim
      response.should be_success
    end
    
    it "should destroy all of the victims" do
      victim = Factory(:victim, :user => @user)
      Factory(:visit, :victim => victim)
      Victim.should_receive(:find_by_slug!).with(victim.slug).and_return(victim)
      
      lambda {
        delete :index, :victim_id => victim.slug
      }.should change(Visit, :count).from(1).to(0)
      
      
      response.should be_redirect
    end
  end
  
end
