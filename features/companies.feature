Feature: Company Details

  Scenario: View company details
    Given I search for "facebook"
    When I click on the "Facebook 'Like' Button" in the products result set
    Then I should be on the "facebook-like-button" product page
    And I should see "When user clicks the Facebook Like button it will automatically place the main product" in overview
    And I should see the following in the milestones list
#      | title                               | first_name | last_name  |
#      | Founder and CEO, Board Of Directors | Mark       | Zuckerberg |
#      | CFO                                 | David      | Ebersman   |
#      | COO                                 | Sheryl     | Sandberg   |
#      | Vice- President and General Counsel | Colin      | Stretch    |

