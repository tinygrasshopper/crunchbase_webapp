Feature: Product Details

  Scenario: View product details
    Given I search for "facebook"
    When I click on the "Facebook" in the companies result set
    Then I should be on the "facebook" company page
    And I should see "Facebook is the world's largest social network, with over" in overview
    And I should see the following in the people list
      | title                               | first_name | last_name  |
      | Founder and CEO, Board Of Directors | Mark       | Zuckerberg |
      | CFO                                 | David      | Ebersman   |
      | COO                                 | Sheryl     | Sandberg   |
      | Vice- President and General Counsel | Colin      | Stretch    |

