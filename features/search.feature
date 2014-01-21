Feature: Search

  Scenario: Search for a term
    Given I am on the home page
    And I search for "mike"
    Then I should see 10 results in the companies result set
    And I should see 8 results in the products result set