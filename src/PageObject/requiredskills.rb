require_relative 'abstract'
require_relative 'details'
require_relative 'confirmation'

# Module with the necessary checks
module Checks
  def check_first_warning_required_skills
    xpath = '//div[6]/div/div[2]'
    wait_to_display_xpath(xpath)
    @driver.find_element(:xpath, xpath).text
  end

  def check_skill(row, number)
    @driver.find_element(:css, '#new_job--step_required_skills > div.form > d'\
  'iv.form__fields > div > div:nth-child(2) > div:nth-child'\
  '(' + (row + 1).to_s + ') > div > div:nth-child'\
  '(' + number.to_s + ')').text[0..-35]
  end

  def check_languages
    @driver.find_element(:xpath, "//form[@id='new_job--step_required_skills']"\
  '/div[2]/div/div/div[2]/div[2]/label/span').text
  end

  def check_frameworks
    @driver.find_element(:xpath, "//form[@id='new_job--step_required_skills']"\
  '/div[2]/div/div/div[2]/div[3]/label/span').text
  end

  def check_libraries_apis
    @driver.find_element(:xpath, "//form[@id='new_job--step_required_skills']"\
  '/div[2]/div/div/div[2]/div[4]/label/span').text
  end

  def check_tools
    @driver.find_element(:xpath, "//form[@id='new_job--step_required_skills']"\
  '/div[2]/div/div/div[2]/div[5]/label/span').text
  end

  def check_paradigms
    @driver.find_element(:xpath, "//form[@id='new_job--step_required_skills']"\
  '/div[2]/div/div/div[2]/div[6]/label/span').text
  end

  def check_platforms
    @driver.find_element(:xpath, "//form[@id='new_job--step_required_skills']"\
  '/div[2]/div/div/div[2]/div[7]/label/span').text
  end

  def check_storage
    @driver.find_element(:xpath, "//form[@id='new_job--step_required_skills']"\
  '/div[2]/div/div/div[2]/div[8]/label/span').text
  end

  def check_misc
    @driver.find_element(:xpath, "//form[@id='new_job--step_required_skills']"\
  '/div[2]/div/div/div[2]/div[9]/label/span').text
  end

  def check_required_skills_input
    @driver.find_element(:id, 'job_skill_sets').attribute('value')
  end
end

# Inherit Abstract methods
class RequiredSkills < Abstract
  include Checks
  def initialize(driver)
    super(driver)
  end

  def fill_required_skills(value)
    id = 'job_skill_sets'
    wait_to_display_id(id)
    @driver.find_element(:id, id).send_keys(value)
    wait_for_value_equal(id, value)
    @driver.action.send_keys(:return).perform
    wait_for_value_equal(id, '')
    RequiredSkills.new(@driver)
  end

  def fill_required_skills_unsuccessful(value)
    id = 'job_skill_sets'
    wait_to_display_id(id)
    @driver.find_element(:id, id).send_keys(value)
    wait = Selenium::WebDriver::Wait.new(timeout: 10) # seconds
    wait.until { (@driver.find_element(:id, id).attribute('value') == value) }
    @driver.action.send_keys(:return).perform
    RequiredSkills.new(@driver)
  end

  def delete_required_skills(category, number)
    if number.to_i > 1
      xpath = "//form[@id='new_job--step_required_skills']/div[2]/div/div/di"\
  'v[2]/div[' + category + ']/div/div[' + number + ']/div[2]/div'
    else
      xpath = "//form[@id='new_job--step_required_skills']/div[2]/div/div/di"\
  'v[2]/div[' + category + ']/div/div/div[2]/div'
    end
    wait_to_display_xpath(xpath)
    @driver.find_element(:xpath, xpath).click
    RequiredSkills.new(@driver)
  end

  def click_next_required_skills_unsuccessful
    @driver.find_element(:css, '#new_job--step_required_skills > div.form > d'\
  'iv.form__controls > div.form__controls_submit > button.big_button').click
    RequiredSkills.new(@driver)
  end

  def click_back_required_skills
    xpath = "//form[@id='new_job--step_required_skills']/div[2]/div[2]/div/di"\
  'v/div'
    wait_to_display_xpath(xpath)
    @driver.find_element(:xpath, xpath).click
    Details.new(@driver)
  end

  def click_cancel_required_skills
    css = '#new_job--step_required_skills > div.form > div.form__controls > d'\
  'iv.form__controls_submit > a.big_button.is-cancel'
    wait_to_display_css(css)
    @driver.find_element(:css, css).click
    Dashboard.new(@driver)
  end

  def click_next_required_skills
    @driver.find_element(:css, '#new_job--step_required_skills > div.form > d'\
  'iv.form__controls > div.form__controls_submit > button.big_button').click
    Confirmation.new(@driver)
  end
end
