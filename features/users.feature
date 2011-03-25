Feature: Users
In order to protect users
As the system administrator
I want to restrict users operations to admin users only

  Scenario: Anonymous user should not see users list
    Given I am an anonymous user

     When I go to the users page
     Then I should be on the login page


  Scenario: Non admin user should not see users list
    Given the following users
      |email         |password|admin|
      |ed@test.com   |secret  |false|
      |jeff@test.com |secret  |false|

     And I am logged in as "ed@test.com" with password "secret"

    When I go to the users page
    Then the response should be a page not found


  Scenario: Admin user should see users list
    Given the following users
      |email         |password|admin|
      |ed@test.com   |secret  |false|
      |jeff@test.com |secret  |false|
      |admin@test.com|secret  |true |

     And I am logged in as "admin@test.com" with password "secret"

    When I go to the users page
    Then the response should be a page not found


  Scenario: User should change his password
    Given the following users
      |email         |password|admin|
      |ed@test.com   |secret  |false|

     And I am logged in as "ed@test.com" with password "secret"

    When I go to the user "ed@test.com" edit page
     And I fill in "password" with "notsosecret"
     And I fill in "password confirmation" with "notsosecret"
     And I click the "Save" action
    Then I should see the "Password changed OK" message
     And I should be on the lists page

