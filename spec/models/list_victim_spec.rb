require 'spec_helper'

describe ListVictim do
  describe "#downloadable?" do
    it "should be false till the API is implemented" do
      Factory.build(:list_victim).should_not be_downloadable
    end
  end
  
  describe "#visit!" do
    it "should create a Visit" do
      victim = Factory.build(:list_victim)

      Curl::Easy.should_receive(:perform).with(victim.url).and_return(mock(:body_str => "", :response_code => 200))

      victim.visit!
    end

    it "should always update #last_visit" do
      victim = Factory(:list_victim)
      Curl::Easy.stub!(:perform).with(victim.url).and_return(mock(:body_str => "", :response_code => 200))
      lambda {
        victim.visit!
      }.should change(victim, :last_visit)
    end

    it "should create an associated VisitList object if it doesn't already exist" do
      victim = Factory(:list_victim)
      Curl::Easy.stub!(:perform).and_return(mock(:body_str => "", :response_code => 200))
      lambda {
        victim.visit!
      }.should change(victim, :visit_list).from(nil).to(VisitList)
    end

    it "should update the existing VisitList object if it already exists" do
      victim = Factory(:list_victim, :visit_list => Factory(:visit_list, :list => []))
      Curl::Easy.stub!(:perform).and_return(mock(:body_str => "", :response_code => 200))
      victim.stub!(:from_selector).and_return( ['foo', 'bar'] )

      lambda {
        victim.visit!
      }.should change(victim.visit_list, :list).from([]).to( ['foo', 'bar'] )
    end
  end

  describe "#chart_data" do
    it "should return a tuple of (date, number of values in list) for charting" do
      now = Time.now
      yesterday = now - 1.day

      victim = Factory(:list_victim)
      victim.visits = [
        Factory(:visit, :victim => victim, :value => ['one', 'two', 'three'], :created_at => yesterday),
        Factory(:visit, :victim => victim, :value => ['four', 'five'], :created_at => now)
      ]

      victim.chart_data.should == [ [now.to_i * 1000, 2], [yesterday.to_i * 1000, 3] ]
    end
  end
end
