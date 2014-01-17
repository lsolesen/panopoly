Feature: Test WYSIWYG integration
  In order to edit text in WYSIWYG mode
  As a site administrator
  I need to be able to use TinyMCE
  
  @api @javascript
  Scenario: Use TinyMCE with media
    Given I am logged in as a user with the "administrator" role
    When I visit "/node/add/panopoly-page"
      And I fill in the following:
        | Title               | Testing text title |
        | Editor              | wysiwyg            |
      And I fill in "Panopoly WYSIWYG media integration rocks" in WYSIWYG editor "edit-body-und-0-value_ifr"
    When I click "edit-body-und-0-value_media"
    Given I wait for 5 seconds
    When I switch to the iframe "mediaBrowser"
    Then I should see "Select a file"
    When I attach the file "panopoly.png" to "files[upload]"
      And I press "Next"
    Given I wait for 5 seconds
    Then I should see the thumbnail
    When I fill in "Alt text" for "Alt Text"
      And I fill in "Title text" for "Title Text"
    When I press "Save"
    Given I wait for 5 seconds
    Then I should see the thumbnail
    #  And I should see "Display as"
    #  And I should see "Alt Text"
    #  And I should see "Title Text"
    # Submit is not a proper link. How to click that?
    When I click "Submit"
    When I press "Publish"
    Then the "h1" element should contain "Testing text title"
      And I should see "Panopoly WYSIWYG Rocks"
      And the "panopoly.png" image should load
