require 'spec_helper'

describe VictimsController do
  
  describe "#index" do
    it "should response successfully" do
      get :index
      response.should be_success
    end
    
    it "should get all of the victims" do
      Victim.should_receive(:all, :include => :visits).once.and_return([])
      get :index
    end
  end
  
end
