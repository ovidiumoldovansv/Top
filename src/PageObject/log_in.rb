require_relative 'abstract'
require_relative 'dashboard'

# Inherit Abstract methods
class LogIn < Abstract
  def initialize(driver)
    super(driver)
  end

  def fill_user(user)
    @driver.find_element(:id, 'user_email').send_keys user
    LogIn.new(@driver)
  end

  def fill_password(password)
    @driver.find_element(:id, 'user_password').send_keys password
    LogIn.new(@driver)
  end

  def click_login
    @driver.find_element(:name, 'commit').click
    Dashboard.new(@driver)
  end

  def click_login_unsuccessful
    @driver.find_element(:name, 'commit').click
    LogIn.new(@driver)
  end

  def check_error
    wait_to_display_css('div.notification-message')
    @driver.find_element(:css, 'div.notification-message').text
  end

  def check_toptal_link
    @driver.find_element(:link, 'Toptal').text
  end

  def check_description
    @driver.find_element(:css, 'div.logo-motto.is-big').text
  end

  def check_login_text
    @driver.find_element(:css, 'h1.modal-content-header').text
  end

  def check_secured_connection
    @driver.find_element(:css, 'div.modal-content-header-login_secured').text
  end

  def check_rememberme
    @driver.find_element(:css, 'span.label').text
  end

  def check_lostpassword
    @driver.find_element(:link, 'Lost password?').text
  end

  def check_footertext
    @driver.find_element(:css, 'div.modal-footer-links').text
  end

  def check_copyright_login
    @driver.find_element(:css, 'div.modal-footer-copyright').text
  end
end
