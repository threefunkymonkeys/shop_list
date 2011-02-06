Feature: Authenticate List creation
In order to protect the system data
As the product owner
I want to users to authenticate for create lists

  Scenario: Require authentication to create a list
    Given I am an anonymous user
     When I go to the lists page
     Then I should be on the login page
      And I should see the "forbidden" message


  Scenario: Authenticated user creates a list
    Given the following users
      |email            |password|
      |test@example.com |secret  |

      And I am logged in as "test@example.com" with password "secret"
      And I have 0 lists
     When I go to the new list page
      And I fill in "name" with "Sample List"
      And I click "Create" action
     Then I should see the "List created OK" message
      And I shold be on the list edit page
      And I should have 1 list

