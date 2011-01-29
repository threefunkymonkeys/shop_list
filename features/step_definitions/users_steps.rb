Given /^the following users$/ do |table|
  table.hashes.each do |attrs|
    user = User.find_by_login(attrs["login"])
    user = User.new({ 
      :login => attrs["login"],
      :password => attrs["password"],
      :password_confirmation => attrs["password"],
      :email => "#{attrs["login"]}@somewhere.com"
    }) unless user
    
    user.should be_valid
    user.save
    user.should_not be_new_record
  end
end

Given /^I am an anonymous user$/ do
  visit '/logout'
  UserSession.find.should be_nil
end

Then /^I should be logged in$/ do
  UserSession.find.should_not be_nil
end

Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |login, password|

  user = User.find_by_login(login)
  user.should_not be_nil
  UserSession.create(user)

  current_user = UserSession.find.record
  current_user.should_not be_nil
  current_user.login.should == login
end

Then /^I should be logged out$/ do
  UserSession.find.should be_nil
end
