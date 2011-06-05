require 'spec_helper'

describe NumericVictim do
  describe "#visit!" do
    it "should create a Visit" do
      victim = Factory.build(:numeric_victim)

      Curl::Easy.should_receive(:perform).with(victim.url).and_return(mock(:body_str => "", :response_code => 200))

      victim.visit!
    end

    it "should always update #last_visit" do
      victim = Factory(:numeric_victim)
      Curl::Easy.should_receive(:perform).with(victim.url).and_return(mock(:body_str => "", :response_code => 200))
      lambda {
        victim.visit!
      }.should change(victim, :last_visit)
    end
  end

  describe "#chart_data" do
    it "should return a tuple of (date, value as number) for charting" do
      now = Time.now
      yesterday = now - 1.day

      victim = Factory(:numeric_victim)
      victim.visits = [
        Factory(:visit, :victim => victim, :value => 10, :created_at => yesterday),
        Factory(:visit, :victim => victim, :value => 100, :created_at => now)
      ]

      victim.chart_data.should == [ [now.to_i * 1000, 100], [yesterday.to_i * 1000, 10] ]
    end
  end
end
