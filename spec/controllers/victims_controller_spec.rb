require 'spec_helper'

describe VictimsController do
  
  describe "#index" do
    it "should get my victims" do
      user = Factory(:user)
      sign_in user
      
      Factory(:victim, :user => user)
      
      get :index
      assigns(:my_victims).should_not be_empty
      response.should be_success
    end
    
    it "should get recent victims" do
      Factory(:victim)
      
      get :index
      assigns(:recent_victims).should_not be_empty
      response.should be_success
    end
    
    it "should get recent visits" do
      Factory(:visit)
      
      get :index
      assigns(:recent_visits).should_not be_empty
      response.should be_success
    end
  end

  describe "#show" do
    it "should find the Victim" do
      victim = Factory(:victim)
      Victim.should_receive(:find).with(victim.id, :include=>[:visits, :unsuccessful_visits, :successful_visits]).and_return(victim)
      
      get :show, :id => victim.id
      
      assigns(:victim).should == victim
      response.should be_success
    end
  end
  
  describe "#new" do
    before do
      @user = Factory(:user)
      sign_in @user
    end
    
    it "should instantiate a new Victim" do
      get :new
      assigns(:victim).should be_new_record
      response.should be_success
    end
  end
  
  describe "#create" do
    before do
      @user = Factory(:user)
      sign_in @user
    end
    
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
    
    it "should set the user to the logged in user" do
      post :create, :victim => Factory.attributes_for(:victim)
      
      @user.victims.should_not be_empty
    end
  end
  
  describe "#edit" do
    before do
      @user = Factory(:user)
      sign_in @user
    end
    
    it "should find the Victim to edit" do
      victim = Factory(:victim, :user => @user)
      get :edit, :id => victim.id
      response.should be_success
    end
  end
  
  describe "#update" do
    before do
      @user = Factory(:user)
      sign_in @user
    end
    
    it "should update the Victim and redirect" do
      victim = Factory(:victim, :user => @user)
      lambda {
        put :update, :id => victim.id, :victim => { :url => "foo" }
        victim.reload
      }.should change(victim, :url)
      response.should be_redirect
    end
    
    it "should not update the Victim and render" do
      victim = Factory(:victim, :user => @user)
      lambda {
        put :update, :id => victim.id, :victim => { :url => "" }
        victim.reload
      }.should_not change(victim, :url)
      response.should render_template(:edit)
    end
    
    it "should not update the Victim if you don't own it" do
      victim = Factory(:victim)
      lambda {
        put :update, :id => victim.id, :victim => { :url => "foo" }
        victim.reload
      }.should_not change(victim, :url)
      response.should be_redirect
    end
  end

  describe "#destroy" do
    before do
      @user = Factory(:user)
      sign_in @user
    end
    
    it "should destroy the Victim" do
      victim = Factory(:victim, :user => @user)
      lambda {
        delete :destroy, :id => victim.id
      }.should change(Victim, :count).from(1).to(0)
      response.should be_redirect
    end
    
    it "should redirect if you don't own the victim" do
      victim = Factory(:victim)
      lambda {
        delete :destroy, :id => victim.id
      }.should_not change(Victim, :count).from(1).to(0)
      response.should be_redirect
    end
  end
  
end
