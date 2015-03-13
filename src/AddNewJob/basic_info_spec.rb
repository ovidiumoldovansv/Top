require 'rspec'
require 'selenium-webdriver'
require_relative '../PageObject/log_in'

RSpec.describe 'Basic Info' do
  app = nil

  before(:each) do
    app = Abstract.new(Selenium::WebDriver.for(:firefox))
  end

  after(:each) do
    app.quit
  end

  it 'Basic Info - No title and no description' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .click_next_unsuccessful

    expect(test.check_first_warning).to be == "You can't leave this empty"
    expect(test.check_second_warning).to be == "You can't leave this empty"
  end

  it 'Basic Info - No title with description' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_description('Test description')
           .click_next_unsuccessful

    expect(test.check_first_warning).to be == "You can't leave this empty"
  end

  it 'Basic Info - With title and no description' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .click_next_unsuccessful

    expect(test.check_first_warning).to be == "You can't leave this empty"
  end

  it 'Basic Info - Cancel' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .click_cancel_basic_info

    expect(test.check_current_jobs).to be == 'Jobs'
  end

  it 'Basic Info - Check pertinence of data' do
    title = '1 !"#$%&()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_'\
  '`abcdefghijklmnopqrstuvwxyz{|}~'
    description = '2 !"#$%&()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXY'\
  'Z[]^_`abcdefghijklmnopqrstuvwxyz{|}~'
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title(title)
           .fill_job_description(description)
           .click_next
           .click_back_details

    expect(test.check_job_title).to be == title
    expect(test.check_job_description).to be == description
  end

  it 'Basic Info - layout' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job

    expect(test.check_page_title).to be == 'Toptal: Exclusive access to top d'\
  'evelopers'
    expect(test.check_new).to be == 'New'
    expect(test.check_pending).to be == 'Pending'
    expect(test.check_verified).to be == 'Verified'
    expect(test.check_add_new_job).to be == 'Add New Job'
    expect(test.check_connect_pal).to be == 'ConnectPal'
    expect(test.check_overview).to be == 'Overview'
    expect(test.check_jobs).to be == 'Jobs'
    expect(test.check_interviews).to be == 'Interviews'
    expect(test.check_team).to be == 'Team'
    expect(test.check_bills).to be == 'Bills'
    expect(test.check_referrals).to be == 'Referrals'
    expect(test.check_send_us_an_email).to be == 'Send us an email'
    expect(test.check_follow_us_on_twitter).to be == 'Follow us on Twitter'
    expect(test.check_call_phone).to be == 'Call 888.604.3188'
    expect(test.check_copyright).to be == '© Copyright 2010 - 2015 Toptal, LLC'
    expect(test.check_privacy_policy).to be == 'Privacy Policy'
    expect(test.check_terms_of_service).to be == 'Terms of Service'
    expect(test.check_add_new_job_label).to be == 'Add New Job'
    expect(test.check_follow_steps_label).to be == 'Follow these steps to add'\
  ' new job'
    expect(test.check_basic_info).to be == 'Basic Info'
    expect(test.check_details).to be == 'Details'
    expect(test.check_required_skills).to be == 'Required Skills'
    expect(test.check_confirm).to be == 'Confirm'
    expect(test.check_tech_call).to be == "What's next?"
    expect(test.check_please_note_label).to be == 'Please note that your job '\
  'will not be viewable by potential candidates until you have completed a te'\
  'ch call with a Director of Engineering. He or she will also help you final'\
  'ize the job description before it goes live.'
  end
end
