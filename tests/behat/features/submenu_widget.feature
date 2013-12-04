Feature: Add submenu widget
  In order to make better navigation of the site
  As a site administrator
  I need to be able to add a submenu widget
 
  @api @javascript
  Scenario: Add submenu widget to page
    Given I am logged in as a user with the "administrator" role
      And Panopoly magic live previews are disabled
    When I visit "/node/add/landing_page"
      And I fill in the following:
        | Title               | Testing [random] title |
        | URL                 | lp-[random:1]          |
      And I press "Create Page"
    Then the "h1" element should contain "Testing [random:1] title"
    When I customize this page with the Panels IPE
      And I click "Add new pane"
      And I click "Add submenu"
    Then I should see "Configure new Add submenu"
    When I check the box "override_title"
      And I fill in the following:
        | override_title_text | Submenu title |
    When I select "2nd level (secondary)" from "edit-level"
      And I check the box "edit-follow"
      And I select "Active menu item" from "follow_parent"
      And I check the box "edit-expanded"
    When I press "edit-return"
      And I press "Save"
      And I wait for the Panels IPE to deactivate
    Then I should see "Submenu title"
      And I should see "Vegetables are great"
    When I customize this page with the Panels IPE
      And I click "Settings"
    # TODO We need to add some logic which tests whether it is possible to
    #      change the checkboxes after hitting save 
      
