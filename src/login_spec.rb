require 'rspec'
require 'selenium-webdriver'
require_relative 'PageObject/log_in'

RSpec.describe 'Login' do
  app = nil

  before(:each) do
    app = Abstract.new(Selenium::WebDriver.for(:firefox))
  end

  after(:each) do
    app.quit
  end

  it 'Login - invalid password' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .fill_password('password1')
           .click_login_unsuccessful

    expect(test.check_error).to be == 'Invalid email or password.'
  end

  it 'Login - invalid user' do
    test = app
           .navigate_to_root
           .fill_user('slava1.connectpal.com@mailinator.com')
           .fill_password('password')
           .click_login_unsuccessful

    expect(test.check_error).to be == 'Invalid email or password.'
  end

  it 'Login - no user and no password' do
    test = app
           .navigate_to_root
           .click_login_unsuccessful

    expect(test.check_error).to be == 'Invalid email or password.'
  end

  it 'Login - no user' do
    test = app
           .navigate_to_root
           .fill_password('password')
           .click_login_unsuccessful

    expect(test.check_error).to be == 'Invalid email or password.'
  end

  it 'Login - no password' do
    test = app
           .navigate_to_root
           .fill_user('slava.connectpal.com@mailinator.com')
           .click_login_unsuccessful

    expect(test.check_error).to be == 'Invalid email or password.'
  end

  it 'Login - layout' do
    test = app
           .navigate_to_root

    expect(test.check_page_title).to be == 'Login | Toptal'
    expect(test.check_toptal_link).to be == 'Toptal'
    expect(test.check_description).to be == 'Exclusive access to top develope'\
  'rs'
    expect(test.check_login_text).to be == 'Login'
    expect(test.check_secured_connection).to be == 'Secured connection'
    expect(test.check_rememberme).to be == 'Remember me'
    expect(test.check_lostpassword).to be == 'Lost password?'
    expect(test.check_footertext).to be == 'No account? Join Toptal as a deve'\
  'loper or company'
    expect(test.check_copyright_login).to be == '© Copyright 2010 - 2015 Topt'\
  'al, LLC'
  end
end
