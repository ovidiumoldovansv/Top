require 'rspec'
require 'selenium-webdriver'
require_relative '../PageObject/log_in'
require_relative '../PageObject/abstract'
require_relative '../PageObject/details'

RSpec.describe 'Confirm' do
  app = nil

  before(:each) do
    app = Abstract.new(Selenium::WebDriver.for(:firefox))
  end

  after(:each) do
    app.quit
  end

  it 'Happy flow' do
    success_text = "Congratulations — you've just added a new job!"
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .select_desired_commitment('Part-time (20+ hours/week)')
           .select_time_zone_prf_yes
           .select_time_zone('(GMT-06:00) Monterrey')
           .select_hours_overlap('11 hours')
           .fill_start_date('11/11/2018')
           .select_estimated_length('2-3 months')
           .fill_spoken_languages('Arabic')
           .delete_spoken_languages('1')
           .click_next_details
           .fill_required_skills('QA')
           .fill_required_skills('Software QA')
           .delete_required_skills('9', '2')
           .click_next_required_skills
           .click_toptal_review
           .click_500_deposit
           .click3days
           .click_next_tech_call

    expect(test.verify_done).to be == success_text
  end

  it 'Confirm - all three warnings' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .fill_start_date('11/11/2018')
           .select_estimated_length('2-3 months')
           .click_next_details
           .fill_required_skills('QA')
           .click_next_required_skills
           .click_next_tech_call_unsuccessful

    expect(test.check_first_warning).to be == 'You need to confirm this'
    expect(test.check_second_warning).to be == 'You need to confirm this'
    expect(test.check_third_warning).to be == 'You need to confirm this'
  end

  it 'Confirm - first warning' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .fill_start_date('11/11/2018')
           .select_estimated_length('2-3 months')
           .click_next_details
           .fill_required_skills('QA')
           .click_next_required_skills
           .click_500_deposit
           .click3days
           .click_next_tech_call_unsuccessful

    expect(test.check_first_warning).to be == 'You need to confirm this'
  end

  it 'Confirm - second warning' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .fill_start_date('11/11/2018')
           .select_estimated_length('2-3 months')
           .click_next_details
           .fill_required_skills('QA')
           .click_next_required_skills
           .click_toptal_review
           .click3days
           .click_next_tech_call_unsuccessful

    expect(test.check_first_warning).to be == 'You need to confirm this'
  end

  it 'Confirm - third warning' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .fill_start_date('11/11/2018')
           .select_estimated_length('2-3 months')
           .click_next_details
           .fill_required_skills('QA')
           .click_next_required_skills
           .click_toptal_review
           .click_500_deposit
           .click_next_tech_call_unsuccessful

    expect(test.check_first_warning).to be == 'You need to confirm '\
  'this'
  end

  it 'Confirm - Cancel' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .fill_start_date('11/11/2018')
           .select_estimated_length('2-3 months')
           .click_next_details
           .fill_required_skills('QA')
           .click_next_required_skills
           .click_cancel_confirm

    expect(test.check_current_jobs).to be == 'Jobs'
  end

  it 'Confirm - Layout' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .fill_start_date('11/11/2018')
           .select_estimated_length('2-3 months')
           .click_next_details
           .fill_required_skills('QA')
           .click_next_required_skills

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
    expect(test.check_first_text).to be == 'I understand that Toptal will rev'\
  'iew this application, talk with me about it, and then start assembling a t'\
  'eam to identify the best candidates for this position.'
    expect(test.check_second_text).to be == 'I understand that I will be char'\
  'ged a $500 deposit that will either go toward my first invoice or be refun'\
  'ded if I do not hire a Toptal developer. This deposit will be waived if I '\
  'have already made alternative arrangements with a Toptal representative.'
    expect(test.check_third_text).to be == 'I understand that I will have thr'\
  'ee business days to reject or schedule an interview with each candidate af'\
  'ter Toptal sends me his/her resume. If I do not notify Toptal, I will be c'\
  'harged $100.'
  end
end
