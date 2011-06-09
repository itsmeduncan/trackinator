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

    it "should validate the type is allowed" do
      Factory.build(:victim, :victim_type => 'Foo').should_not be_valid
    end
  end

  describe "downloadable?" do
    it "should be false for the base class" do
      Factory.build(:victim).should_not be_downloadable
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

  describe "#victim_type=" do
    it "should set the type properly" do
      Factory.build(:victim, :victim_type => 'FooType').type.should == 'FooType'
    end
  end

  describe "#victim_type" do
    it "should return the correct type" do
      Factory.build(:numeric_victim, :victim_type => 'FooType').victim_type.should == 'FooType'
    end
  end

  describe "#visit!" do
    it "should raise a NotImplementedError" do
      lambda {
        Factory.build(:victim).visit!
      }.should raise_exception NotImplementedError
    end
  end

  describe "#chart_data" do
    it "should only use the successuful visits" do
      now = Time.now

      victim = Factory(:victim)
      successful_visit = Factory(:visit, :victim => victim, :created_at => now)
      victim.visits = [
        successful_visit,
        Factory(:visit, :victim => victim, :status => 404)
      ]

      victim.should_receive(:chart_data_value).with(successful_visit).and_return(99)
      victim.chart_data.should == [ [now.to_i * 1000, 99] ]
    end

    it "should raise a NotImplementedException" do
      victim = Factory(:victim)
      victim.visits = [ Factory(:visit, :victim => victim) ]

      lambda {
        victim.chart_data
      }.should raise_exception NotImplementedError
    end
  end

  describe "#editable_by" do
    it "should be true if the user created the Victim" do
      victim = Factory.build(:victim, :user_id => 20_000)
      victim.editable_by(mock(User, :id => 20_000)).should be_true
    end
    
    it "should be false if the user doesn't own the Victim" do
      victim = Factory.build(:victim, :user_id => 1)
      victim.editable_by(mock(User, :id => 20_000)).should be_false
    end
    
    it "should be false if there is no user passed in" do
      victim = Factory.build(:victim, :user_id => 1)
      victim.editable_by(nil).should be_false
    end
  end

  describe "before_update clear visits" do
    it "should delete all visits if the selector is changed" do
      victim = Factory(:victim, :name => "Foo")
      Factory(:visit, :victim => victim)

      lambda {
        victim.selector = "foo"
        victim.save
      }.should change(Visit, :count).from(1).to(0)
    end

    it "should not delete visits if the selector hasn't changed" do
      victim = Factory(:victim, :name => "Foo")
      Factory(:visit, :victim => victim)

      lambda {
        victim.name = "foo"
        victim.save
      }.should_not change(Visit, :count).from(1).to(0)
    end
  end
end
