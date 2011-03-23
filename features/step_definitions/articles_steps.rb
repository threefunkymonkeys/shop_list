Given /^the following articles$/ do |table|
  table.hashes.each do |attrs|
    owner = User.find_by_email(attrs["owner"])
    owner.should_not be_nil

    Article.create(:name => attrs["name"], :user_id => owner.id).should_not be_nil
  end
end
