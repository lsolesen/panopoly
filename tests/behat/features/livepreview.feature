Feature: Live preview
  In order to do more WYSIWYG
  As a site administrator
  I need to be able to have a live preview of my changes to the widgets
 
  @api @javascript
  Scenario: Test whether the live preview works correctly
    Given I am logged in as a user with the "administrator" role
    When I visit "/node/add/panopoly-page"
      And I fill in the following:
        | Title               | Testing text title |
        | Editor              | plain_text         |
        | body[und][0][value] | Testing text body  |
      And I press "Publish"
    Then the "h1" element should contain "Testing text title"
    When I customize this page with the Panels IPE
      And I click "Add new pane"
      And I click "Add text"
    Then I should see "Configure new Add text"
    When I fill in the following:
      | Title   | Text widget title       |
      | Editor  | plain_text              |
      | Text    | Testing text body field |
    When I wait for live preview to finish
      And I press "Save"
      And I press "Save as custom"
      And I wait for the Panels IPE to deactivate
    Then I should see "Text widget title"
      And I should see "Testing text body field"
