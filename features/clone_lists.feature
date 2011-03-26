Feature: Clone Lists
In order to make the application easier to use
As a registered user
I want to be able to clone existent lists

  Scenario: Clone Lists
    Given the following users
      |email         |password    |
      |ed@test.com   |secret      |

      And the following lists from the users
        |name        |user          |
        |Ed's List   |ed@test.com   |

      And I am logged in as "ed@test.com" with password "secret"
     When I go to the lists page
      And I click the clone action for the list named "Ed's List"
     Then I should see "Ed's List (1)"
      And I should see the "List cloned OK" message
      And I should be on the list named "Ed's List (1)" edit page
