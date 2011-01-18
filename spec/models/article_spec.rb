require 'spec_helper'

describe Article do
  it "should have a name" do
    article = Article.new
    article.should_not be_valid
  end
end
