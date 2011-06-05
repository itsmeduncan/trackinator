require 'spec_helper'

describe VisitList do
  describe "#list" do
    it "should serialize the list properly" do
      Factory(:visit_list, :list => ['one', 'two', 'three'])
      VisitList.first.list.should == ['one', 'two', 'three']
    end
  end
end
