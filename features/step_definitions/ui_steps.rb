Then /^I should see the "([^"]*)" message$/ do |message|
  locale_msg = I18n.translate("application.messages.#{message.downcase.gsub(" ", "_")}")
  locale_msg.should_not include "translation missing:"
  page.should have_content locale_msg
end

When /^I click the "([^"]*)" action$/ do |action|
  locale_action = I18n.translate("application.actions.#{action.downcase.gsub(" ", "_")}")
  locale_action.should_not include "translation missing:"

  click_link_or_button locale_action
end

When /^I click the remove action for the "([^"]*)" article"$/ do |name|
  article = Article.find_by_name name
  article.should_not be_nil

  click_link_or_button "remove_article_#{article.id}"
end
