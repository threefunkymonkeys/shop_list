Feature: Login users
In order to protect the relialability of the information
As the product owner
I want users to login

Scenario: User should be able to login
  Given the following users
    |login|password|
    |test |secret  |

    And I am an anonymous user
   When I go to the login page
    And I fill in "login" with "test"
    And I fill in "password" with "secret"
    And I click the "Login" action in the current locale
   Then I should be logged in 
    And I should be on the homepage


Scenario: User should be able to logout
  Given the following users
    |login|password|
    |test |secret  |
    And I am logged in as "test" with password "secret"
   When I go to the logout page
   Then I should be logged out
    And I should be on the homepage

