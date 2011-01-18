require File.expand_path('../../spec_helper', __FILE__)

describe List do
  it "should have a name" do
    list = List.new
    list.should_not be_valid
  end

  it "should have a total of zero if is has no items" do
    list = List.new
    list.total.should == 0
  end

  it "should sum the individual items prices in order to get the total"
end
