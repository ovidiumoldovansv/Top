require 'rspec'
require 'selenium-webdriver'
require_relative 'log_in'

# Abstract class
class Abstract
  @driver = nil

  def initialize(driver)
    @driver = driver
  end

  def navigate_to_root
    @driver.navigate.to('https://toptal:staging@staging.toptal.net/users/logi'\
  'n')
    @driver.manage.timeouts.implicit_wait = 10 # seconds
    @driver.manage.window.maximize
    LogIn.new(@driver)
  end

  def quit
    @driver.quit
  end

  def wait_to_display_id(value)
    wait = Selenium::WebDriver::Wait.new(timeout: 10) # seconds
    wait.until { (@driver.find_element(id: value).displayed?) }
  end

  def wait_to_display_css(value)
    wait = Selenium::WebDriver::Wait.new(timeout: 10) # seconds
    wait.until { (@driver.find_element(css: value).displayed?) }
  end

  def wait_to_display_xpath(value)
    wait = Selenium::WebDriver::Wait.new(timeout: 10) # seconds
    wait.until { (@driver.find_element(xpath: value).displayed?) }
  end

  def check_page_title
    @driver.title
  end

  def check_new
    @driver.find_element(:css, '.status_badge__status.is-new.js-tooltip').text
  end

  def check_pending
    @driver.find_element(:css, '.status_badge__status.is-pending.js-toolti'\
  'p').text
  end

  def check_verified
    @driver.find_element(:css, '.status_badge__status.is-verified.js-toolti'\
  'p').text
  end

  def check_add_new_job
    @driver.find_element(:link, 'Add New Job').text
  end

  def check_connect_pal
    @driver.find_element(:css, 'div.top_nav__user_name.g-text_overflow').text
  end

  def check_current_jobs
    @driver.find_element(:css, '.title__text').text
  end

  def check_overview
    @driver.find_element(:css, 'div.menu__item_link_inner').text
  end

  def check_jobs
    @driver.find_element(:css, '.menu__item_link.js-main_menu__item_link.has-'\
  'icon.for-jobs > div:nth-child(1)').text
  end

  def check_interviews
    @driver.find_element(:css, '.menu__item_link.js-main_menu__item_link.has-i'\
  'con.for-interview').text
  end

  def check_team
    @driver.find_element(:css, '.menu__item_link.js-main_menu__item_link.has-i'\
  'con.for-team').text
  end

  def check_bills
    @driver.find_element(:css, '.menu__item_link.js-main_menu__item_link.has-i'\
  'con.for-bills > div:nth-child(1)').text
  end

  def check_referrals
    @driver.find_element(:css, '.menu__item_link.js-main_menu__item_link.has-i'\
  'con.for-referrals').text
  end

  def check_send_us_an_email
    @driver.find_element(:link, 'Send us an email').text
  end

  def check_follow_us_on_twitter
    @driver.find_element(:link, 'Follow us on Twitter').text
  end

  def check_call_phone
    @driver.find_element(:css, 'div.footer__left > span:nth-child(3)').text
  end

  def check_copyright
    @driver.find_element(:css, 'div.footer__right > span.footer__text').text
  end

  def check_privacy_policy
    @driver.find_element(:link, 'Privacy Policy').text
  end

  def check_terms_of_service
    @driver.find_element(:link, 'Terms of Service').text
  end

  def check_add_new_job_label
    @driver.find_element(:css, 'h2.title__text').text
  end

  def check_follow_steps_label
    @driver.find_element(:css, 'div.panel__header').text
  end

  def check_basic_info
    @driver.find_element(:css, 'div.step__text_inner').text
  end

  def check_details
    @driver.find_element(:css, 'div.step.js-wizard__tab.is-details > div.step'\
  '__text > div').text
  end

  def check_required_skills
    @driver.find_element(:css, 'div.step.js-wizard__tab.is-required_skills > '\
  'div.step__text > div').text
  end

  def check_confirm
    @driver.find_element(:css, 'div.step.js-wizard__tab.is-confirmation > div'\
  '.step__text > div').text
  end

  def check_tech_call
    @driver.find_element(:css, 'div.step.js-wizard__tab.is-next.is-last > div'\
  '.step__text > div').text
  end

  def wait_for_value_equal(id, value)
    wait = wait_until
    wait.until { (@driver.find_element(:id, id).attribute('value') == value) }
  end

  def wait_until
    Selenium::WebDriver::Wait.new(timeout: 10) # seconds
  end
end
