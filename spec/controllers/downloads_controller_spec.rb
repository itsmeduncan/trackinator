require 'spec_helper'

describe DownloadsController do

  it "should respond with CSV" do
    victim = Factory(:victim)
    get :show, :id => victim.id, :format => :csv
    
    response.headers["Content-Type"].should =~ /text\/csv/
    
    response.should be_success
  end
  
  it "should respond with JSON" do
    victim = Factory(:victim)
    get :show, :id => victim.id, :format => :json

    response.headers["Content-Type"].should =~ /application\/json/

    response.should be_success
  end
  
  it "should respond with XML" do
    victim = Factory(:victim)
    get :show, :id => victim.id, :format => :xml

    response.headers["Content-Type"].should =~ /application\/xml/

    response.should be_success
  end
  
end
