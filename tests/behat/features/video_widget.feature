Feature: Add video widget
  In order to add a video
  As a site administrator
  I need to be able to use the video widget

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
    When I customize this page with the Panels IPE
      And I click "Add new pane"
      And I click "Add video"
    Then I should see "Configure new Add video"

  @api @javascript
  Scenario: Add a video
    When I fill in "Testing video" for "edit-title"
    When I click "Select"
    Given I wait for 5 seconds
    Then I should see "Enter an image URL or an embed code"
      And I should see "Supported providers"
      And I should see "YouTube"
      And I should see "Vimeo"
    When I fill in "http://www.youtube.com/watch?v=1TV0q4Sdxlc" for "edit-embed-code"
      And I press "Submit"
    Then I should see "Edit"
      And I should see "Remove"
    When I press "edit-return"
      And I press "Save as custom"
      And I wait for the Panels IPE to deactivate
    Then I should see "Testing video"
