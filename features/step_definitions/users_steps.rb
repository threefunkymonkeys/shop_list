Given /^the following users$/ do |table|
  table.hashes.each do |attrs|
    user = User.find_by_email(attrs["email"])
    user = User.summon({ 
      :email => attrs["email"],
      :password => attrs["password"],
      :password_confirmation => attrs["password"],
    }) unless user
    
    user.should be_valid
    #user.save.should be_true
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

Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |email, password|

  #user = User.find_by_email(email)
  #user.should_not be_nil
  #UserSession.create(user)

  #current_user = UserSession.find.record
  #current_user.should_not be_nil
  #current_user.email.should == email
  
  visit "/login"
  fill_in("email", :with => email)
  fill_in("password", :with => password)
  click_link_or_button("login")
  UserSession.find.should_not be_nil
end

Then /^I should be logged out$/ do
  UserSession.find.should be_nil
end

Given /^I have no lists$/ do 
  current_user = UserSession.find.record
  current_user.should_not be_nil
  current_user.lists = []
end

Then /^I should have (\d+) list(s?)$/ do |count, _|
  current_user = UserSession.find.record
  current_user.lists.count.should == count.to_i
end

Then /^I should be able to authenticate with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  user = User.find_by_email(email)
  user.should_not be_nil
  user.should be_valid_password password
end

Then /^the response should be a page not found$/ do
  page.driver.status_code.should == 404
end
