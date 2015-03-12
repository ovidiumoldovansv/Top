require_relative 'abstract'
require_relative 'dashboard'
require_relative 'details'

# Inherit Abstract methods
class BasicInfo < Abstract
  def initialize(driver)
    super(driver)
  end

  def fill_job_title(name)
    @driver.find_element(:id, 'new_job_title').send_keys name
    BasicInfo.new(@driver)
  end

  def fill_job_description(description)
    @driver.find_element(:id, 'new_job_description').send_keys description
    BasicInfo.new(@driver)
  end

  def click_next
    @driver.find_element(:css, 'div.form__controls_submit > button').click
    Details.new(@driver)
  end

  def click_next_unsuccessful
    @driver.find_element(:css, 'div.form__controls_submit > button').click
    BasicInfo.new(@driver)
  end

  def click_cancel_basic_info
    css = 'a.big_button.is-cancel'
    wait_to_display_css(css)
    @driver.find_element(:css, css).click
    Dashboard.new(@driver)
  end

  def check_first_warning
    @driver.find_element(:xpath, '//div[4]/div/div[2]').text
  end

  def check_second_warning
    @driver.find_element(:xpath, '//div[4]/div[2]/div[2]').text
  end

  def check_please_note_label
    @driver.find_element(:css, 'div.form__note_inner').text
  end

  def check_job_title
    @driver.find_element(:id, 'new_job_title').attribute('value')
  end

  def check_job_description
    @driver.find_element(:id, 'new_job_description').attribute('value')
  end
end
