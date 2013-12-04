Feature: Search
  In order to know search is working
  As a website user
  When I search for something I should see the results

  Background:
    Given I am on "/search"

  Scenario: Trying an empty search should yield a message
    Then I should see "Search"
      And I should not see "Search Results"
    When I enter "stuff" for "Enter your keywords"
      And press "Search"
    Then I should see "Search Results"
      And I should see "Enter your keywords"
  
   Scenario: Trying a search with no results
    Then I should see "Search"
      And I should not see "Search Results"
    When I enter "stuff" for "Enter your keywords"
      And press "Search"
    Then I should see "Search Results"
      And I should see "0 items matched stuff"
      And I should see "Your search did not return any results."
