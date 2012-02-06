Given /^I am on (.*?)$/ do |page_name|
  visit path_to(page_name)
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field_name_or_id, content|
  fill_in(field_name_or_id, :with => content)
end

When /^I click "([^"]*)"$/ do |thing_to_click|
  click_button(thing_to_click)
end

Then /^I should see "([^"]*)" in the message list$/ do |content|
  page.should have_content(content)
end
