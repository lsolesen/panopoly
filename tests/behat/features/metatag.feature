@api
Feature: Be able to rewrite title and description
  In order to optimize SEO
  As a site administrator
  I want to overwrite page title and meta description

  Background:
    Given I am logged in as a user with the "administrator" role

  Scenario: Rewrite title and description
    When I visit "/node/add/panopoly-page"
      And I fill in the following:
        | Title               | Testing title           |
        | Editor              | plain_text              |
        | body[und][0][value] | Testing body            |
        | Page title          | My SEO optimized title  |
        | Description         | My SEO optimized descr. |
      And I press "Publish"
    Then the "h1" element should contain "Testing title"
      And I should see "My SEO optimized title" in the "Title" element
      And the metatag attribute "description" should have the value "My SEO optimized descr."

