Given /^the following lists from the users$/ do |table|
  table.hashes.each do |attrs|
    user = User.find_by_email(attrs["user"])
    user.should_not be_nil
    list = List.summon(:user_id => user.id, :name => attrs["name"])    
    list.should be_valid
    list.should_not be_new_record
  end
end

Given /^I have a list named "([^"]*)"$/ do |list_name|
  current_user_session = UserSession.find
  current_user_session.should_not be_nil
  current_user = current_user_session.record

  list = List.summon(:name => list_name, :user_id => current_user.id)
  list.should be_valid
  list.should_not be_new_record
end


When /^I click the clone action for the list named "([^"]*)"$/ do |list_name|
  list = List.find_by_name(list_name)
  list.should_not be_nil
  click_link_or_button "clone_list_#{list.id}"
end
