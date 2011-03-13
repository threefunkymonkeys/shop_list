require 'spec_helper'

describe Article do
  it "should have a name" do
    article = Article.new
    article.should_not be_valid
    article.name = "Crackers"
    article.should be_valid
  end

  it "should belong to a user" do
    user = Summoner.summon(:user)
    article = Summoner.summon(:article, :user_id => user.id)

    user.reload
    user.article_ids.should include article.id
  end
end
