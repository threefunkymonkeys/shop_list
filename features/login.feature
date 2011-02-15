Feature: Login users
In order to protect the relialability of the information
As the product owner
I want users to login

  Scenario: User should be able to login
    Given the following users
      |email              |password|
      |test@somewhere.com |secret  |

      And I am an anonymous user
    When I go to the login page
      And I fill in "email" with "test@somewhere.com"
      And I fill in "password" with "secret"
      And I click the "Login" action
    Then I should be logged in 
      And I should be on the lists page


  Scenario: User should be able to logout
    Given the following users
      |email              |password|
      |test@somewhere.com |secret  |

      And I am logged in as "test@somewhere.com" with password "secret"
    When I go to the logout page
    Then I should be logged out
      And I should be on the homepage

  Scenario: Anonymous user should be able to register
    Given I am an anonymous user
      And I go to the register page
      And I fill in "email" with "jeff@test.com"
      And I fill in "password" with "secret"
      And I fill in "password_confirmation" with "secret"
      And I click the "Register" action
    Then I should see the "User Register OK" message
      And I should be able to authenticate with email "jeff@test.com" and password "secret"

  Scenario: Anonymous user should be logged in after register
    Given I am an anonymous user
      And I go to the register page
      And I fill in "email" with "jeff@test.com"
      And I fill in "password" with "secret"
      And I fill in "password_confirmation" with "secret"
      And I click the "Register" action
    Then I should see the "User Register OK" message
      And I should be logged in
