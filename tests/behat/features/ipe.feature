Feature: Add content list widget
  In order to create a list of certain content
  As a site administrator
  I need to be able to add a list with the content I choose
 
  @api @javascript
  Scenario: Add a content list
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
      And I click "Add text"
    Then I should see "Configure new Add text"
    When I fill in the following:
      | Title                                | Title text test         |
      | Editor                               | plain_text              |
      | field_basic_text_text[und][0][value] | Body text test          |
      And I press "edit-return"
      And I press "Save as custom"
      And I wait for the Panels IPE to deactivate
    Then I should see "Title text test"
    Then I should see "Body text test"
    When I customize this page with the Panels IPE
    When I click "Style" in the "Content" region
    # For some reason the Pane Style modal only shows ""
    Then I should see "Pane style for "
    When I press "Next"
    When I press "Save"
      And I wait for the Panels IPE to deactivate
    Then I should see "Title text test"
    When I customize this page with the Panels IPE
    When I click "Delete" in the "Content" region
    When I press "OK"
    #Given I accept the alert dialog
    When I press "Save"
      And I wait for the Panels IPE to deactivate
    Then I should not see "Title text test"
