Feature: Post and view messages
  In order to communicate with other site visitors
  As a visitor
  I want to post and view messages in a live chat view
  
  Scenario: Post a message to the chat window
    Given I am on the chat page
    When I fill in "message" with "Hello everybody"
    And I click "Send"
    Then I should see "Hello everybody" in the message list
