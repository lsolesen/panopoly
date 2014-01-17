<?php
/**
 * @file
 * Provide Behat step-definitions as Drupal Extension subcontexts.
 */

use Drupal\DrupalExtension\Context\DrupalSubContextInterface;
use Behat\MinkExtension\Context\MinkAwareInterface;
use Behat\Behat\Context\BehatContext;

class MediaSubContext extends BehatContext implements DrupalSubContextInterface {
  public static function getAlias() {
    return 'media';
  }

  /**
    * Drupal Media Module 7.x-1.3
    *
    * @When /^I wait for the upload to finish$/
    */
   public function iWaitForTheUploadToFinish() {
     $duration = 30000; // 30 seconds
     $this->getMainContext()->getSession()->wait($duration, '(0 === jQuery.active)');
   }

  /**
   * Drupal Media Module 7.x-1.3
   * 
   * @Given /^I switch to the iframe "([^"]*)"$/
   */
  public function iSwitchToTheIframe($name) {
      if ($name) {
        $this->getMainContext()->getSession()->switchToIFrame($name);
      } else {
        $this->getMainContect()->getSession()->switchToIFrame();
      }
  }

  public function checkForImage($url) {
    $ch  = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_exec($ch);
    // get the content type
    $mime_type = curl_getinfo($ch, CURLINFO_CONTENT_TYPE);
    if (strpos($mime_type, 'image/') === FALSE) {
      throw new Exception (sprintf('%s did not return an image', $url));

    }
  }

  /**
   * Drupal Media Module 7.x-1.3
   *
   * @Then /^I should see the thumbnail$/
   */
  public function iShouldSeeTheThumbnail() {
    $page = $this->getMainContext()->getSession()->getPage();
    // Find the thumbnail image.
    $thumbnail = $page->find('css','.media-thumbnail img'); 
    if (empty($thumbnail)) {
      throw new Exception (sprintf('The expected image tag was not found on %s' ,  $this->getMainContext()->getSession()->getCurrentUrl()));
    }
    // Check that the thumbnail loads
    $thumb_href = $thumbnail->getAttribute('src');
    $this->checkForImage($thumb_href);
  }

  /**
   * Drupal Media Module 7.x-1.3
   *
   * @Then /^the "([^"]*)" image should load$/
   */
  public function theImageShouldLoad($image) {
    $page = $this->getMainContext()->getSession()->getPage();
    // Find the image.
    $image = $page->find('css','.field-type-image img');
    if (empty($image)) {
      throw new Exception (sprintf('The expected image tag was not found on %s' ,  $this->getMainContext()->getSession()->getCurrentUrl()));
    }
    // Check that the image loads
    $image_href = $image->getAttribute('src');
    $this->checkForImage($image_href);
  }
}
