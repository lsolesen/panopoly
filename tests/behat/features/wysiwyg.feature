Feature: Test WYSIWYG integration
  In order to edit text in WYSIWYG mode
  As a site administrator
  I need to be able to use TinyMCE
 
  @api @javascript
  Scenario: Use TinyMCE
    Given I am logged in as a user with the "administrator" role
    When I visit "/node/add/panopoly-page"
      And I fill in the following:
        | Title               | Testing text title |
        | Editor              | wysiwyg            |
      And I fill in "Panopoly WYSIWYG rocks" in WYSIWYG editor "edit-body-und-0-value_ifr"
      And I press "Publish"
    Then the "h1" element should contain "Testing text title"
      And I should see "Panopoly WYSIWYG Rocks"
