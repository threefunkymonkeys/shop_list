Feature: Article Management
In order to protect my articles
As a registered user
I want to be able to manage only my articles

  Scenario: Article listing
    Given the following users
      | email          | password |
      | me@test.com    | secret   |
      | other@test.com | secret   |
    
     And the following articles
       | name    | owner          |
       | Coffee  | me@test.com    |
       | Cookies | other@test.com |

     And I am logged in as "me@test.com" with password "secret"
    When I go to the articles page
    Then I should see "Coffe"
     And I should not see "Cookies"


  Scenario: Should see only own articles
    Given the following users
      | email          | password |
      | me@test.com    | secret   |
      | other@test.com | secret   |
    
     And the following articles
       | name    | owner          |
       | Coffee  | me@test.com    |
       | Cookies | other@test.com |

     And I am logged in as "me@test.com" with password "secret"
    When I go to the "Cookies" article page
    Then I should see the "Article Not Found" message
     And I should be on the articles page


