Feature: Search

  Scenario: Search for a term
    Given I am on the home page
    And I search for "facebook"
    Then I should see the following in the companies result set
      | name     | description    |
      | Facebook | Social network |
    Then I should see 1 results in the companies result set
    Then I should see the following in the products result set
      | name                   |
      | Facebook 'Like' Button |
    And I should see 1 results in the products result set

