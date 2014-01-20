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
    # TODO Actually I should not see the menu as no submenu should be 
    # visible when there is no children
    Then I should see "Submenu title"
      And I should see "Vegetables are great"
    # Attempt to change the checkboxes after saving originally
    When I customize this page with the Panels IPE
      And I click "Settings" in the "Boxton Content" region
    Then the "edit-follow" checkbox should be checked
      And the "edit-expanded" checkbox should be checked
    When I uncheck the box "edit-follow"
      And I uncheck the box "edit-expanded"
    When I press "edit-return"
      And I wait for the Panels IPE to deactivate
      And I press "Save"
      And I customize this page with the Panels IPE
      And I click "Settings" in the "Boxton Content" region
    Then the "edit-follow" checkbox should not be checked
      And the "edit-expanded" checkbox should not be checked

  @api @javascript
  Scenario: Submenu should be predictable - see issue #2177417
    Given I am logged in as a user with the "administrator" role
      And Panopoly magic live previews are disabled
    # Create two different pages
    When I visit "/node/add/panopoly-page"
      And I fill in the following:
        | Title               | Main item [random] |
        | Editor              | plain_text         |
        | body[und][0][value] | Testing body       |
        | path[alias]         | cp-[random:1]      |
      And I check the box "menu[enabled]"
      And I fill in "Main item [random:1]" for "menu[link_title]"
      And I select "<Main menu>" from "menu[parent]"
      And I press "Publish"
    Then the "h1" element should contain "Main item [random:1]"
    When I customize this page with the Panels IPE
      And I click "Add new pane"
      And I click "Add submenu"
    Then I should see "Configure new Add submenu"
    When I check the box "override_title"
      And I fill in the following:
        | override_title_text | Submenu on main item |
    When I select "2nd level (secondary)" from "edit-level"
      And I check the box "edit-follow"
      And I select "Active menu item" from "follow_parent"
      And I check the box "edit-expanded"
    When I press "edit-return"
      And I press "Save as custom"
      And I wait for the Panels IPE to deactivate
    # TODO Enable this when the test above has been fixed
    # Then I should not see "Submenu on main item"
    #  And I should not see "Vegetables are great"

    When I visit "/node/add/panopoly-page"
      And I fill in the following:
        | Title               | Sub item     |
        | Editor              | plain_text   |
        | body[und][0][value] | Testing body |
      And I check the box "menu[enabled]"
      And I fill in "Sub item" for "menu[link_title]"
      And I select "-- Main item" from "menu[parent]"
      And I press "Publish"
    Then the "h1" element should contain "Sub item"
    When I customize this page with the Panels IPE
      And I click "Add new pane"
      And I click "Add submenu"
    Then I should see "Configure new Add submenu"
    When I check the box "override_title"
      And I fill in the following:
        | override_title_text | Submenu on main item |
    When I select "2nd level (secondary)" from "edit-level"
      And I check the box "edit-follow"
      And I select "Active menu item" from "follow_parent"
      And I check the box "edit-expanded"
    When I press "edit-return"
      And I press "Save as custom"
      And I wait for the Panels IPE to deactivate
    Then I should not see "Submenu title"
    Given I wait for 10 seconds
    When I click "Main item [random:1]"
    Then I should see "Submenu on main item"
      And I should see "Sub item"
