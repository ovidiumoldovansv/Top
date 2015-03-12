require_relative 'abstract'
require_relative 'basic_info'
require_relative 'requiredskills'

# Inherit Abstract methods
class Details < Abstract
  def initialize(driver)
    super(driver)
  end

  def select_desired_commitment(value)
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, 'new_j'\
  'ob_commitment')).select_by(:text, value)
    Details.new(@driver)
  end

  def select_time_zone_prf_yes
    @driver.find_element(:id, 'job_prefer_timezone_yes').click
    Details.new(@driver)
  end

  def select_time_zone(value)
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, 'new_j'\
  'ob_time_zone_name')).select_by(:text, value)
    Details.new(@driver)
  end

  def select_hours_overlap(value)
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, 'new_j'\
  'ob_hours_overlap')).select_by(:text, value)
    Details.new(@driver)
  end

  def fill_start_date(value)
    id = 'new_job_start_date'
    wait_to_display_id(id)
    @driver.find_element(:id, id).send_keys(value)
    Details.new(@driver)
  end

  def select_estimated_length(value)
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, 'new_j'\
  'ob_estimated_length')).select_by(:text, value)
    Details.new(@driver)
  end

  def fill_spoken_languages(value)
    id = 'new_job_languages'
    @driver.find_element(:id, id).send_keys(value)
    wait_for_value_equal(id, value)
    @driver.action.send_keys(:return).perform
    wait_for_value_equal(id, '')
    Details.new(@driver)
  end

  def fill_spoken_languages_unsuccessful(value)
    @driver.find_element(:id, 'new_job_languages').send_keys(value)
    wait_for_value_equal(id, value)
    @driver.action.send_keys(:return).perform
    Details.new(@driver)
  end

  def delete_spoken_languages(value)
    xpath = "//form[@id='new_job--step_details']/div[2]/div/div/div[10]/div/"\
  'div[' + value + ']/div/div'
    @driver.find_element(:xpath, xpath).click
    Details.new(@driver)
  end

  def click_next_details
    @driver.find_element(:css, '#new_job--step_details > div.form >div.form__'\
  'controls >div.form__controls_submit > button').click
    RequiredSkills.new(@driver)
  end

  def click_next_details_unsuccessful
    @driver.find_element(:css, '#new_job--step_details > div.form >div.form__'\
  'controls >div.form__controls_submit > button').click
    Details.new(@driver)
  end

  def click_back_details
    @driver.find_element(:css, '.big_button.is-cancel.js-back').click
    BasicInfo.new(@driver)
  end

  def click_cancel_details
    css = '#new_job--step_details > div.form > div.form__controls > div.form_'\
  '_controls_submit > a.big_button.is-cancel'
    wait_to_display_css(css)
    @driver.find_element(:css, css).click
    Dashboard.new(@driver)
  end

  def check_language_warning
    css = 'span.base_error__body'
    wait_to_display_css(css)
    @driver.find_element(:css, css).text
  end

  def check_first_warning
    xpath = '//body/div[2]/div/div[2]/div/div[5]/div/div[2]'
    wait_to_display_xpath(xpath)
    @driver.find_element(:xpath, xpath).text
  end

  def check_second_warning
    @driver.find_element(:xpath, '//div[5]/div[2]/div[2]').text
  end

  def check_desired_commitment
    @driver.find_element(:id, 'new_job_commitment').attribute('value')
  end

  def check_time_zone_preference_yes
    @driver.find_element(:id, 'job_prefer_timezone_yes').selected?
  end

  def check_time_zone
    @driver.find_element(:id, 'new_job_time_zone_name').attribute('value')
  end

  def check_hours_overlap
    @driver.find_element(:id, 'new_job_hours_overlap').attribute('value')
  end

  def check_start_date
    @driver.find_element(:id, 'new_job_start_date').attribute('value')
  end

  def check_estimated_length
    @driver.find_element(:id, 'new_job_estimated_length').attribute('value')
  end

  def check_spoken_languages
    css = '#new_job--step_details > div.form > div.form__fields > div > div.u'\
  'i-textbox.for-languages.is-big.is-new_job.is-wide.form-field.js-field_wrap'\
  'per.languages.required.job_languages > div > div:nth-child(2) > span'
    wait_to_display_css(css)
    @driver.find_element(:css, css).text
  end

  def check_spoken_languages_input
    @driver.find_element(:id, 'new_job_languages').attribute('value')
  end
end
