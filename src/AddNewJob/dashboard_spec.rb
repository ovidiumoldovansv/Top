require 'rspec'
require 'selenium-webdriver'
require_relative '../PageObject/log_in'

RSpec.describe 'Dashboard' do
  app = nil

  before(:each) do
    app = Abstract.new(Selenium::WebDriver.for(:firefox))
  end

  after(:each) do
    app.quit
  end

  it 'Dashboard - layout' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login

    expect(test.check_page_title).to be == 'Toptal: Exclusive access to top d'\
  'evelopers'
    expect(test.check_new).to be == 'New'
    expect(test.check_pending).to be == 'Pending'
    expect(test.check_verified).to be == 'Verified'
    expect(test.check_add_new_job).to be == 'Add New Job'
    expect(test.check_connect_pal).to be == 'ConnectPal'
    expect(test.check_current_jobs).to be == 'Current Jobs'
    expect(test.check_signed_in_successfully).to be == 'Signed in successfully.'
    expect(test.check_overview).to be == 'Overview'
    expect(test.check_jobs).to be == 'Jobs'
    expect(test.check_interviews).to be == 'Interviews'
    expect(test.check_team).to be == 'Team'
    expect(test.check_bills).to be == 'Bills'
    expect(test.check_referrals).to be == 'Referrals'
    expect(test.check_recent_activity).to be == 'Recent Activity'
    expect(test.check_upcoming).to be == 'Upcoming'
    expect(test.check_send_us_an_email).to be == 'Send us an email'
    expect(test.check_follow_us_on_twitter).to be == 'Follow us on Twitter'
    expect(test.check_call_phone).to be == 'Call 888.604.3188'
    expect(test.check_copyright).to be == '© Copyright 2010 - 2015 Toptal, LLC'
    expect(test.check_privacy_policy).to be == 'Privacy Policy'
    expect(test.check_terms_of_service).to be == 'Terms of Service'
  end
end
