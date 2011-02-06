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
  fill_in(:email, :with => email)
  fill_in(:password, :with => password)
  click_link_or_button(:login)
  response.should be_ok
  UserSession.find.should_not be_nil
end

Then /^I should be logged out$/ do
  UserSession.find.should be_nil
end

Given /^I have (\d+) lists$/ do |count|
  current_user = UserSession.find.record
  current_user.lists.count.should == count.to_i
end
