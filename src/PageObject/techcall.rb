require_relative 'abstract'
require_relative 'confirmation'

# Inherit Abstract methods
class TechCall < Abstract
  def initialize(driver)
    super(driver)
  end

  def verify_done
    css_verify_done = 'div.wizard_complete__title'
    wait_to_display_css(css_verify_done)
    @driver.find_element(:css, css_verify_done).text
  end
end
