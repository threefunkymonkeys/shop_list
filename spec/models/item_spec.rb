require 'spec_helper'

describe Item do
  it "should belong to an article" do
    item = Summoner.summon :item, :article => nil
    item.should_not be_valid
  end

  it "should belong to a list" do
    item = Summoner.summon :item, :list => nil
    item.should_not be_valid
  end

  it "should have a quantity greater than zero" do
    item = Summoner.summon :item, :quantity => 0
    item.should_not be_valid
  end
end
