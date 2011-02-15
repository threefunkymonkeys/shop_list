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
      And I have no lists
     When I go to the new list page
      And I fill in "name" with "Sample List"
      And I click the "Save" action
     Then I should see the "List created OK" message
      And I should be on the list edit page
      And I should have 1 list

  Scenario: Authenticated users should see only their lists
    Given the following users
      |email         |password    |
      |ed@test.com   |secret      |
      |jeff@test.com |notsosecret |

      And the following lists from the users
        |name        |user          |
        |Ed's List   |ed@test.com   |
        |Jeff's List |jeff@test.com |

     And I am logged in as "ed@test.com" with password "secret"
    When I go to the lists page
    Then I should see "Ed's List"
     And I should not see "Jeff's List"

  Scenario: Authenticated users should be able to edit their lists
    Given the following users
      |email        |password|
      |test@test.com|secret  |

      And I am logged in as "test@test.com" with password "secret"
      And I have a list named "Test List"
     When I go to the list named "Test List" edit page
      And I fill in "name" with "Super List"
      And I click the "Save" action
     Then I should see the "List Updated OK" message
      And I should see "Super List"
      And I should not see "Test List"

  Scenario: Authenticated users should not be able to edit someone else's lists
    Given the following users
      |email         |password    |
      |ed@test.com   |secret      |
      |jeff@test.com |notsosecret |

      And the following lists from the users
        |name        |user          |
        |Ed's List   |ed@test.com   |
        |Jeff's List |jeff@test.com |

     And I am logged in as "ed@test.com" with password "secret"
    When I go to the list named "Jeff's List" edit page
    Then I should be on the lists page
     And I should see the "Forbidden" message

