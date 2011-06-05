require 'spec_helper'

describe ListVictim do
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
end
