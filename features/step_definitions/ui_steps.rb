Then /^I should see the "([^"]*)" message$/ do |message|
  locale_msg = I18n.translate("application.messages.#{message.downcase.gsub(" ", "_")}")
  locale_msg.should_not include "translation missing:"
  page.should have_content locale_msg
end

When /^I click the "([^"]*)" action in the current locale$/ do |action|
  locale_action = I18n.translate("application.actions.#{action.downcase.gsub(" ", "_")}")
  locale_action.should_not include "translation missing:"

  click_link_or_button locale_action
end
