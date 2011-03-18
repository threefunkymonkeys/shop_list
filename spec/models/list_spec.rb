require File.expand_path('../../spec_helper', __FILE__)

describe List do
  it "should have a name" do
    list = List.new
    list.should_not be_valid

    list.name = "Groceries"
    list.should be_valid
  end

  it "should have a total of zero if is has no items" do
    list = List.new
    list.total.should == 0
  end

  it "should associate the item list when item is added" do
    item = Summoner.summon :item, :list => nil
    list = Summoner.summon :list

    list << item
    item.list.should == list
  end

  it "should compute the total from items' quantities and prices" do
    list  = Summoner.summon :list
    item1 = Summoner.summon :item, :price => 10, :quantity => 1, :article_id => 1
    item2 = Summoner.summon :item, :price => 15, :quantity => 2, :article_id => 2

    list << item2
    list.total.should == 30

    list << item1
    list.total.should == 40
  end

  it "should increment the quantity of an item if added more than once" do
    list  = Summoner.summon :list
    item = Summoner.summon :item, :price => 10, :quantity => 1

    list << item
    list.items.first.quantity.should == 1

    list << item
    list.items.first.quantity.should == 2
  end
end
