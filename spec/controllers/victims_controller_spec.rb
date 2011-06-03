require 'spec_helper'

describe VictimsController do
  
  describe "#index" do
    it "should response successfully" do
      get :index
      response.should be_success
    end
    
    it "should get all of the victims" do
      Victim.should_receive(:all).with(:include=>[:visits, :unsuccessful_visits, :successful_visits]).once.and_return([])
      get :index
    end
  end

  describe "#show" do
    it "should find the Victim" do
      victim = Factory(:victim)
      Victim.should_receive(:find_by_slug).with(victim.slug, :include=>[:visits, :unsuccessful_visits, :successful_visits]).and_return(victim)
      
      get :show, :id => victim.slug
      
      assigns(:victim).should == victim
      response.should be_success
    end
  end
  
  describe "#new" do
    it "should instantiate a new Victim" do
      get :new
      assigns(:victim).should be_new_record
      response.should be_success
    end
  end
  
  describe "#create" do
    it "should create a Victim and redirect" do
      lambda {
        post :create, :victim => Factory.attributes_for(:victim)
      }.should change(Victim, :count).from(0).to(1)

      response.should be_redirect
    end
    
    it "should not create a Victim and render" do
      lambda {
        post :create, :victim => Factory.attributes_for(:victim, :name => "")
      }.should_not change(Victim, :count).from(0).to(1)

      response.should render_template(:new)
    end
  end
  
  describe "#edit" do
    it "should find the Victim to edit" do
      victim = Factory(:victim)
      get :edit, :id => victim.to_param
      response.should be_success
    end
  end
  
  describe "#update" do
    it "should update the Victim and redirect" do
      victim = Factory(:victim)
      lambda {
        put :update, :id => victim.to_param, :victim => { :url => "foo" }
        victim.reload
      }.should change(victim, :url)
      response.should be_redirect
    end
    
    it "should not update the Victim and render" do
      victim = Factory(:victim)
      lambda {
        put :update, :id => victim.to_param, :victim => { :url => "" }
        victim.reload
      }.should_not change(victim, :url)
      response.should render_template(:edit)
    end
  end

  describe "#destroy" do
    it "should destroy the Victim" do
      victim = Factory(:victim)
      lambda {
        delete :destroy, :id => victim.to_param
      }.should change(Victim, :count).from(1).to(0)
      response.should be_redirect
    end
  end
  
end
