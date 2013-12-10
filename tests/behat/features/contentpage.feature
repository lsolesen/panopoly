Feature: Add content page
  In order to create a page with content
  As a site administrator
  I need to be able create a content page

  Background: 
    Given I am logged in as a user with the "administrator" role
      And Panopoly magic live previews are disabled
    When I visit "/node/add/panopoly-page"
      And I fill in the following:
        | Title               | Testing title |
        | Editor              | plain_text    |
        | body[und][0][value] | Testing body  |

  @api
  Scenario: Add a content page
    When I press "Publish"
    Then the "h1" element should contain "Testing title"

  @api @javascript
  Scenario: Cannot update alt text per issue #207161
    When I attach the file "panopoly.png" to "files[field_featured_image_und_0]"
    Then I should see "The specified file panopoly.png could not be uploaded. The image is too small; the minimum dimensions are 300x200 pixels."
    # Notice that if the first image is not validated, the automatic upload does not work anymore
    When I attach the file "screenshot.png" to "files[field_featured_image_und_0]"
      And I press "Upload"
    When I fill in "Panopoly rocks" for "field_featured_image[und][0][alt]"
      And I press "Publish"
    Then I should see the link "Edit" in the "Tabs" region
    When I click "Edit" in the "Tabs" region
    Then the "field_featured_image[und][0][alt]" field should contain "Panopoly rocks"
