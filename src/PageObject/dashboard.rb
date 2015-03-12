require_relative 'abstract'
require_relative 'log_in'
require_relative 'basic_info'

# Inherit Abstract methods
class Dashboard < Abstract
  def initialize(driver)
    super(driver)
  end

  def click_add_new_job
    @driver.find_element(:link_text, 'Add New Job').click
    BasicInfo.new(@driver)
  end

  def check_signed_in_successfully
    @driver.find_element(:css, 'div.notice.is-notice').text
  end

  def check_recent_activity
    @driver.find_element(:css, 'h2.panel__header_title').text
  end

  def check_upcoming
    @driver.find_element(:css, 'div.panel.for-dashboard > div.panel__header >'\
  ' h2.panel__header_title').text
  end
end
