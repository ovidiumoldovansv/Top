require 'rspec'
require 'selenium-webdriver'
require_relative '../PageObject/log_in'

RSpec.describe 'Details' do
  app = nil

  before(:each) do
    app = Abstract.new(Selenium::WebDriver.for(:firefox))
  end

  after(:each) do
    app.quit
  end

  it 'Details - empty fields warnings' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .select_time_zone_prf_yes
           .delete_spoken_languages('1')
           .click_next_details_unsuccessful

    expect(test.check_language_warning).to be == "Languages: You can't leave "\
  'this empty'
    expect(test.check_first_warning).to be == "You can't leave this empty"
    expect(test.check_second_warning).to be == "You can't leave this empty"
  end

  it 'Details - empty language warning' do
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
           .select_time_zone('(GMT+13:00) Tokelau Is.')
           .select_hours_overlap('12 hours')
           .fill_start_date('01/11/2018')
           .select_estimated_length('Unknown')
           .delete_spoken_languages('1')
           .click_next_details_unsuccessful

    expect(test.check_language_warning).to be == "Languages: You can't leave "\
  'this empty'
  end

  it 'Details - empty estimated length warning' do
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
           .select_time_zone('(GMT+13:00) Tokelau Is.')
           .select_hours_overlap('1 hour')
           .fill_start_date('01/12/2018')
           .click_next_details_unsuccessful

    expect(test.check_first_warning).to be == "You can't leave this empty"
  end

  it 'Details - empty desired start date warning' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .select_desired_commitment('Hourly (no restrictions)')
           .select_time_zone_prf_yes
           .select_time_zone('(GMT-11:00) American Samoa')
           .select_hours_overlap('6 hours')
           .select_estimated_length('12+ months')
           .click_next_details_unsuccessful

    expect(test.check_first_warning).to be == "You can't leave this empty"
  end

  it 'Details - invalid desired start date warning - 29/02/2017' do
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
           .fill_start_date('29/02/2017')
           .select_estimated_length('2-3 months')
           .fill_spoken_languages('French')
           .delete_spoken_languages('1')
           .click_next_details_unsuccessful

    expect(test.check_first_warning).to be == 'Invalid date format'
  end

  it 'Details - invalid desired start date warning - 0/09/2018' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .fill_start_date('0/09/2018')
           .select_estimated_length('2-3 months')
           .click_next_details_unsuccessful

    expect(test.check_first_warning).to be == 'Invalid date format'
  end

  it 'Details - invalid desired start date warning - 4/0/2019' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .fill_start_date('4/0/2019')
           .select_estimated_length('2-3 months')
           .click_next_details_unsuccessful

    expect(test.check_first_warning).to be == 'Invalid date format'
  end

  it 'Details - invalid desired start date warning - 13/13/2019' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .fill_start_date('13/13/2019')
           .select_estimated_length('2-3 months')
           .click_next_details_unsuccessful

    expect(test.check_first_warning).to be == 'Invalid date format'
  end

  it 'Details - start date in the past - this test will fail because of bug' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .fill_start_date('1/1/2000')
           .select_estimated_length('2-3 months')
           .click_next_details_unsuccessful

    expect(test.check_first_warning).to be == 'Invalid date'
  end

  it 'Details - invalid desired start date warning - random text' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .fill_start_date('random')
           .select_estimated_length('2-3 months')
           .click_next_details_unsuccessful

    expect(test.check_first_warning).to be == 'Invalid date format'
  end

  it 'Details - Different combinations 1' do
    desired_commitment_selected = 'Full-time (40+ hours/week)'
    desired_commitment_verified = 'full_time'
    time_zone_prf_yes = false
    time_zone = ''
    hours_overlap = ''
    start_date = '31/12/2015'
    estimated_length_selected = 'Unknown'
    estimated_length_value = '7'
    spoken_languages = 'French'
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .select_desired_commitment(desired_commitment_selected)
           .fill_start_date(start_date)
           .select_estimated_length(estimated_length_selected)
           .fill_spoken_languages(spoken_languages)
           .delete_spoken_languages('1')
           .click_next_details
           .click_back_required_skills

    expect(test.check_desired_commitment).to be == desired_commitment_verified
    expect(test.check_time_zone_preference_yes).to be == time_zone_prf_yes
    expect(test.check_time_zone).to be == time_zone
    expect(test.check_hours_overlap).to be == hours_overlap
    expect(test.check_start_date).to be == start_date
    expect(test.check_estimated_length).to be == estimated_length_value
    expect(test.check_spoken_languages).to be == spoken_languages
  end

  it 'Details - Different combinations 2' do
    desired_commitment_selected = 'Part-time (20+ hours/week)'
    desired_commitment_verified = 'part_time'
    time_zone_prf_yes = true
    time_zone = ''
    hours_overlap = ''
    start_date = '01/01/2016'
    estimated_length_selected = '12+ months'
    estimated_length_value = '6'
    spoken_languages = 'Italian'
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .select_desired_commitment(desired_commitment_selected)
           .select_time_zone_prf_yes
           .fill_start_date(start_date)
           .select_estimated_length(estimated_length_selected)
           .fill_spoken_languages(spoken_languages)
           .delete_spoken_languages('1')
           .click_next_details
           .click_back_required_skills

    expect(test.check_desired_commitment).to be == desired_commitment_verified
    expect(test.check_time_zone_preference_yes).to be == time_zone_prf_yes
    expect(test.check_time_zone).to be == time_zone
    expect(test.check_hours_overlap).to be == hours_overlap
    expect(test.check_start_date).to be == start_date
    expect(test.check_estimated_length).to be == estimated_length_value
    expect(test.check_spoken_languages).to be == spoken_languages
  end

  it 'Details - Different combinations 3' do
    desired_commitment_selected = 'Hourly (no restrictions)'
    desired_commitment_verified = 'hourly'
    time_zone_prf_yes = true
    time_zone_selected = '(GMT+13:00) Tokelau Is.'
    time_zone_value = 'Tokelau Is.'
    hours_overlap_selected = '12 hours'
    hours_overlap_value = '12'
    start_date = '30/06/2016'
    estimated_length_selected = '2-3 months'
    estimated_length_value = '3'
    spoken_languages = 'Portuguese'
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .select_desired_commitment(desired_commitment_selected)
           .select_time_zone_prf_yes
           .select_time_zone(time_zone_selected)
           .select_hours_overlap(hours_overlap_selected)
           .fill_start_date(start_date)
           .select_estimated_length(estimated_length_selected)
           .delete_spoken_languages('1')
           .fill_spoken_languages(spoken_languages)
           .click_next_details
           .click_back_required_skills

    expect(test.check_desired_commitment).to be == desired_commitment_verified
    expect(test.check_time_zone_preference_yes).to be == time_zone_prf_yes
    expect(test.check_time_zone).to be == time_zone_value
    expect(test.check_hours_overlap).to be == hours_overlap_value
    expect(test.check_start_date).to be == start_date
    expect(test.check_estimated_length).to be == estimated_length_value
    expect(test.check_spoken_languages).to be == spoken_languages
  end

  it 'Details - Cancel' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next
           .click_cancel_details

    expect(test.check_current_jobs).to be == 'Jobs'
  end

  it 'Details - add same language again - will fail because of bug' do
    spoken_languages = 'English'
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
           .delete_spoken_languages('1')
           .fill_spoken_languages(spoken_languages)

    expect(test.check_spoken_languages).to be == spoken_languages
  end

  it 'Details - Check that a language cannot be added more than once' do
    spoken_languages = 'Japanese'
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
           .delete_spoken_languages('1')
           .fill_spoken_languages(spoken_languages)
           .fill_spoken_languages_unsuccessful(spoken_languages)

    expect(test.check_spoken_languages).to be == spoken_languages
    expect(test.check_spoken_languages_input).to be == spoken_languages
  end

  it 'Details - Layout' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login
           .click_add_new_job
           .fill_job_title('Test Job')
           .fill_job_description('Test description')
           .click_next

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
  end
end
