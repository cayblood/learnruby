Given /^I am on (.*?)$/ do |page_name|
  visit path_to(page_name)
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When /^I click "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "([^"]*)" in the message list$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end