require_relative 'abstract'
require_relative 'requiredskills'
require_relative 'techcall'

# Inherit Abstract methods
class Confirmation < Abstract
  def initialize(driver)
    super(driver)
  end

  def click_toptal_review
    id = 'new_job_accept_review'
    wait_to_display_id(id)
    @driver.find_element(:id, id).click
    Confirmation.new(@driver)
  end

  def click_500_deposit
    id = 'new_job_accept_deposit'
    wait_to_display_id(id)
    @driver.find_element(:id, id).click
    Confirmation.new(@driver)
  end

  def click3days
    id = 'new_job_accept_interview'
    wait_to_display_id(id)
    @driver.find_element(:id, id).click
    Confirmation.new(@driver)
  end

  def click_next_tech_call
    @driver.find_element(:css, '#new_job--step_confirmation > div.form > div.'\
  'form__controls > div.form__controls_submit > button.big_button').click
    TechCall.new(@driver)
  end

  def click_next_tech_call_unsuccessful
    css = '#new_job--step_confirmation > div.form > div.form__controls > div.'\
  'form__controls_submit > button.big_button'
    wait_to_display_css(css)
    @driver.find_element(:css, css).click
    Confirmation.new(@driver)
  end

  def click_back_confirmation
    xpath = "//form[@id='new_job--step_confirmation']/div[2]/div[2]/div/div"
    wait_to_display_xpath(xpath)
    @driver.find_element(:xpath, xpath).click
    RequiredSkills.new(@driver)
  end

  def click_cancel_confirm
    css = '#new_job--step_confirmation > div.form > div.form__controls > div.'\
  'form__controls_submit > a.big_button.is-cancel'
    wait_to_display_css(css)
    @driver.find_element(:css, css).click
    Dashboard.new(@driver)
  end

  def check_first_warning
    xpath = '//div[7]/div/div[2]'
    wait_to_display_xpath(xpath)
    @driver.find_element(:xpath, xpath).text
  end

  def check_second_warning
    @driver.find_element(:xpath, '//div[7]/div[3]/div[2]').text
  end

  def check_third_warning
    @driver.find_element(:xpath, '//div[7]/div[2]/div[2]').text
  end

  def check_first_text
    @driver.find_element(:css, 'div.is-review').text
  end

  def check_second_text
    @driver.find_element(:css, 'div.is-deposit').text
  end

  def check_third_text
    @driver.find_element(:css, 'div.is-three-days-interview').text
  end
end
