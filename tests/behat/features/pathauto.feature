Feature: Test pathauto
  In order to get nice urls
  As a site administrator
  I need to be able to trust that pathauto works consistently

  Background:
    Given I am logged in as a user with the "administrator" role
      And Panopoly magic live previews are disabled
    When I visit "/node/add/panopoly-page"
      And I fill in the following:
        | Title               | Testing title |
        | Editor              | plain_text    |
        | body[und][0][value] | Testing body  |
      And I press "Publish"
    Then the "h1" element should contain "Testing title"

  @api
  Scenario: Pathauto should automatically assign an url
    Then the url should match "testing-title"
  
  @api
  Scenario: Pathauto should keep old url when changing the title
    When I click "Edit" in the "Tabs" region
      And I fill in the following:
        | Title               | Completely other title |
      And I press "Save"
    Then the url should match "testing-title"
    Given I go to "completely-other-title"
    Then the response status code should be 404

  @api
  Scenario: My own permalink should be kept even if changing title
    When I click "Edit" in the "Tabs" region
      And I fill in the following:
        | Permalink           | my-custom-permalink |
      And I press "Save"
    Then the url should match "my-custom-permalink"
    When I click "Edit" in the "Tabs" region
      And I fill in the following:
        | Title               | Saving Title Again  |
      And I press "Save"
    Then the url should match "my-custom-permalink"
    Given I go to "my-custom-permalink"
    Then the response status code should be 200
    # Original Permalink should forward to new permalink
    Given I go to "testing-title"
    Then the response status code should be 301

  @api @javascript
  Scenario: Retain alias when using IPE - Issue #2239847
    Given I am logged in as a user with the "administrator" role
    And Panopoly magic live previews are disabled
    When I visit "/node/add/panopoly-page"
    And I fill in the following:
      | Title               | Testing IPE title       |
      | Permalink           | my-ipe-custom-permalink |
      | Editor              | plain_text              |
      | body[und][0][value] | Testing body            |
    And I press "Publish"
    Then the "h1" element should contain "Testing IPE title"
    Then the url should match "my-ipe-custom-permalink"
    When I customize this page with the Panels IPE
      And I click "Add new pane"
      And I click "Add text"
    Then I should see "Configure new Add text"
    When I fill in the following:
      | Title   | Text widget title       |
      | Editor  | plain_text              |
      | Text    | Testing text body field |
      And I press "edit-return"
      And I press "Save as custom"
      And I wait for the Panels IPE to deactivate
    Then the url should match "my-ipe-custom-permalink"
    When I reload the page
    Then the url should match "my-ipe-custom-permalink"
    When I click "Edit" in the "Tabs" region
    Then the "path[alias]" field should contain "my-ipe-custom-permalink"
