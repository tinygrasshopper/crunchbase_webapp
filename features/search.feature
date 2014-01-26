Feature: Search

  Scenario: Search for a term
    Given I am on the home page
    And I search for "facebook"
    Then I should see the following company results
      | name     | description    |
      | Facebook | Social network |
#    Then I should see 1 results in the companies result set

#    And I should see 1 results in the products result set

