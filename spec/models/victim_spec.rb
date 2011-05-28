require 'spec_helper'

describe Victim do
  describe "validations" do
    it "should make a valid victim" do
      Factory(:victim).should be_valid
      Factory.build(:victim).should be_valid
    end
    
    it "should validate the uniqueness of name" do
      Factory(:victim, :name => "foo")
      Factory.build(:victim, :name => "foo").should_not be_valid
    end
    
    [:name, :url, :selector, :interval, :last_visit].each do |attr|
      it "should validate the presence of #{attr}" do
        Factory.build(:victim, attr => nil).should_not be_valid
      end
    end
  end
  
  describe "#default_scope" do
    it "should return Victims in name ASC order" do
      Factory(:victim, :name => 'foo')
      Factory(:victim, :name => 'bar')
      
      Victim.all.collect(&:name).should == ["bar", "foo"]
    end
  end
  
  describe "Victim#visitable" do
    it "should return only visitible Victims" do
      Factory(:victim, :last_visit => 3.hours.ago, :interval => 1.hour.to_i)
      Victim.visitable.should_not be_empty
    end
    
    it "should return nothing if there is nothing visitable" do
      Factory(:victim, :last_visit => 1.hour.ago, :interval => 2.hours.to_i)
      Victim.visitable.should be_empty
    end
  end
  
  describe "Victim#create_from_arguments" do
    it "should create a new Victim" do
      victim_attributes = Factory.attributes_for(:victim)
      lambda {
        Victim.create_from_arguments(victim_attributes)
      }.should change(Victim, :count).from(0).to(1)
    end
    
    it "should not create a new Victim" do
      victim_attributes = Factory.attributes_for(:victim, :name => nil)
      lambda {
        Victim.create_from_arguments(victim_attributes)
      }.should_not change(Victim, :count).from(0).to(1)
    end
  end
  
  describe "Victim#destroy_from_arguments" do
    it "should destroy the victim" do
      victim = Factory(:victim)
      lambda {
        Victim.destroy_from_arguments({:name => victim.name})
      }.should change(Victim, :count).from(1).to(0)
    end
    
    it "should fail to destroy the victim" do
      victim = Factory(:victim)
      lambda {
        Victim.destroy_from_arguments({:name => nil})
      }.should_not change(Victim, :count).from(1).to(0)
    end
  end
  
  describe "#visit!" do
    it "should create a Visit" do
      victim = Factory.build(:victim)
      
      Curl::Easy.should_receive(:perform).with(victim.url).and_return(mock(:body_str => "", :response_code => 200))

      victim.visit!
    end

    it "should always update #last_visit" do
      victim = Factory(:victim)
      lambda {
        victim.visit!
      }.should change(victim, :last_visit)
    end
  end
end
