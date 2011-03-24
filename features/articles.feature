Feature: Article Management
In order to protect my articles
As a registered user
I want to be able to manage only my articles

  Scenario: List own articles
    Given the following users
      | email          | password |
      | me@test.com    | secret   |
      | other@test.com | secret   |
    
     And the following articles
       | name    | owner          |
       | Coffee  | me@test.com    |
       | Tea     | me@test.com    |
       | Cookies | other@test.com |

     And I am logged in as "me@test.com" with password "secret"
    When I go to the articles page
    Then I should see "Coffe"
     And I should see "Coffe"
     And I should not see "Cookies"


  Scenario: Should not see other people's articles
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


  Scenario: Should not edit other people's articles
    Given the following users
      | email          | password |
      | me@test.com    | secret   |
      | other@test.com | secret   |
    
     And the following articles
       | name    | owner          |
       | Coffee  | me@test.com    |
       | Cookies | other@test.com |

     And I am logged in as "me@test.com" with password "secret"
    When I go to the article named "Cookies" edit page
    Then I should see the "Article Not Found" message
     And I should be on the articles page


  Scenario: Should edit own articles
    Given the following users
      | email          | password |
      | me@test.com    | secret   |
      | other@test.com | secret   |
    
     And the following articles
       | name    | owner          |
       | Coffee  | me@test.com    |
       | Cookies | other@test.com |

     And I am logged in as "me@test.com" with password "secret"
    When I go to the article named "Coffee" edit page
     And I fill in "name" with "Instant Coffee"
     And I click the "Save" action
    Then I should see "Instant Coffee"
     And I should see the "Article updated OK" message
     And I should be on the articles page


  Scenario: Should delete own articles
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
     And I click the remove action for the "Coffee" article"
     And I should see the "Article destroyed OK" message
     And I should be on the articles page

