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
end
