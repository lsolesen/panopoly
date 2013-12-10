Feature: Search
  In order to know search is working
  As a website user
  When I search for something I should see the results

  Background:
    Given I am on "/search"

  Scenario: Testing correct wording for search
    Then I should see "Search"
      And I should not see "Search Results"
    
  Scenario: Trying an empty search should yield a message
    When I enter "" for "Enter your keywords"
      And press "Search"
    Then I should see "Search Results"
      And I should see "Enter your keywords"
  
   Scenario: Trying a search with no results
    When I enter "NoSearchResultsWillShow" for "Enter your keywords"
      And press "Search"
    Then I should see "Search Results"
      And I should see "0 items matched NoSearchResultsWillShow"
      And I should see "Your search did not return any results."

   Scenario: Trying a search with results
    When I enter "vegetables" for "Enter your keywords"
      And press "Search"
    Then I should see "Search Results"
      And I should see "3 items matched vegetables"
      And the "keys" field should contain "vegetables"
      And I should see "Filter by Type"
