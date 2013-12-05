Feature: Accessibility
  In order to know that images are providing meaningful text to screen readers
  As a website user
  When a screen reader detects an image it should state descriptive text

  Scenario: Screenreader interpreting an image alt link in media field
    Given I am on homepage
    Then I should see the image alt "Fresh Veggies So Good" in the "Content"

  Scenario: Screenreader interpreting an image alt link in wysiwyg field
    Given I am on homepage
    When I click "Content Demo"
    Then I should see the image alt "Fresh Veggies So Good" in the "Content"

