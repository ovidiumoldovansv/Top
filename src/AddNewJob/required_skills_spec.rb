require 'rspec'
require 'selenium-webdriver'
require_relative '../PageObject/log_in'

RSpec.describe 'Required Skills' do
  app = nil

  before(:each) do
    app = Abstract.new(Selenium::WebDriver.for(:firefox))
  end

  after(:each) do
    app.quit
  end

  it 'Required Skills - no skills selected' do
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
           .click_next_required_skills_unsuccessful

    expect(test.check_first_warning).to be == 'You need to specify at least o'\
  'ne skill'
  end

  it 'Required Skills - Check pertinence of skills' do
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
           .fill_required_skills('C#')
           .fill_required_skills('SQL')
           .fill_required_skills('Ruby on Rails')
           .fill_required_skills('Django')
           .fill_required_skills('jQuery')
           .fill_required_skills('Facebook API')
           .fill_required_skills('SoapUI')
           .fill_required_skills('PL/SQL Developer')
           .fill_required_skills('Functional programming')
           .fill_required_skills('Scrum')
           .fill_required_skills('OS X')
           .fill_required_skills('Linux')
           .fill_required_skills('Oracle')
           .fill_required_skills('MS SQL')
           .fill_required_skills('Project management')
           .fill_required_skills('QA')
           .click_next_required_skills
           .click_back_confirmation

    expect(test.check_skill(1, 1)).to be == 'C#'
    expect(test.check_skill(1, 2)).to be == 'SQL'
    expect(test.check_skill(2, 1)).to be == 'Ruby on Rails'
    expect(test.check_skill(2, 2)).to be == 'Django'
    expect(test.check_skill(3, 1)).to be == 'jQuery'
    expect(test.check_skill(3, 2)).to be == 'Facebook API'
    expect(test.check_skill(4, 1)).to be == 'SoapUI'
    expect(test.check_skill(4, 2)).to be == 'PL/SQL Developer'
    expect(test.check_skill(5, 1)).to be == 'Functional programming'
    expect(test.check_skill(5, 2)).to be == 'Scrum'
    expect(test.check_skill(6, 1)).to be == 'OS X'
    expect(test.check_skill(6, 2)).to be == 'Linux'
    expect(test.check_skill(7, 1)).to be == 'Oracle'
    expect(test.check_skill(7, 2)).to be == 'MS SQL'
    expect(test.check_skill(8, 1)).to be == 'Project Management'
    expect(test.check_skill(8, 2)).to be == 'QA'
  end

  it 'Required Skills - Cancel' do
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
           .click_cancel_required_skills

    expect(test.check_current_jobs).to be == 'Jobs'
  end

  it 'Required Skills - Check that a skill cannot be added more than once' do
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
           .fill_required_skills('Software QA')
           .fill_required_skills_unsuccessful('Software QA')

    expect(test.check_skill(8, 1)).to be == 'Software QA'
    expect(test.check_required_skills_input).to be == 'Software QA'
  end

  it 'Required Skills - Layout' do
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
    expect(test.check_languages).to be == 'Languages'
    expect(test.check_frameworks).to be == 'Frameworks'
    expect(test.check_libraries_apis).to be == 'Libraries/APIs'
    expect(test.check_tools).to be == 'Tools'
    expect(test.check_paradigms).to be == 'Paradigms'
    expect(test.check_platforms).to be == 'Platforms'
    expect(test.check_storage).to be == 'Storage'
    expect(test.check_misc).to be == 'Misc'
  end
end
