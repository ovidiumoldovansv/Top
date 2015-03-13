# Top
CONTENTS OF THIS FILE
---------------------
  
* Introduction
* Prerequisites 
* Environment Installation
* Test cases 
* How to run 
* How to read the results 

INTRODUCTION
------------

This is an automation testing project. The scope of the project is to verify that the firms using the Toptal website are able to create a new job. 
Please find below the details about the environment and steps to run the tests.

PREREQUISITES
-------------

* Firefox 36.0.1
* Ruby 2.1.5 
* Ruby gems:
	* RSpec 3.2.0
	* Selenium webdriver 2.45.0
* Project code (last commit in Github: https://github.com/ovidiumoldovansv/Top)

for more details about how to install the above tools please check Environment Installation section.

ENVIRONMENT INSTALLATION 
------------------------

Exemplification for Windows 8 OS:

* Firefox installation:
	* Download the Mozilla Firefox executable file from: https://www.mozilla.org/en-US/firefox/new/?scene=2#download-fx  
	* Click Run to launch the Mozilla Firefox setup wizard and follow the steps to complete installation 
* Ruby installation:
	* Download the Ruby version 2.5.1 from: http://rubyinstaller.org/downloads/
	* Click Run to launch the Ruby setup wizard and follow the steps to complete the installation. 
	(Make sure the following options are checked  in Installation Destination and Optional Tasks dialog:  
	'Install Td/Tk support', 'Add Ruby executables to your PATH' and 'Associate .rb and .rbw files with this Ruby installation')
	* Check the successfully installation. Run the following command from the command line: 
		* 'ruby -v' -> it should return your ruby version 
		* 'set' -> ruby locations should be added in your Path
* RSpec installation:
	* run the following command from your command line: 'gem install rspec -v 3.2.0'
	* check RSpec gem installation:  
		* run the following command from your command line: "gem list" -> rspec components like rspec, rspec-core, rspec-expectations, etc should exist in the list.
* WebDriver installation:
	* run the following command from your command line: 'gem install selenium-webdriver -v 2.45.0'
	* check Selenium gem installation:  
		* run the following command from your command line: "gem list" -> webdriver components should exist in the list.

TEST CASES 
----------

The test cases are organized in two big sections:
	1. Login test-cases.
	2. Create job test-cases.
	
The test cases for creating a new job are also divided in 5 sections:
	1. Dashboard page validation.
	2. Basic info page validation.
	3. Details page validation.
	4. Basic skills page validation.
	5. Confirmation page validation. 

HOW TO RUN:
-----------
* Make sure the latest code from github is downloaded 
* Open the command line and navigate to the resource folder (src)
* Run the following command to run each of the following suites:
	* 'ruby -Ilib -Ispec -rrspec/autorun login_spec.rb'
		=> will run the 6 login test cases 
		=> results with displayed in the command line 
		=> use '> results.txt' parameter have the results exported in a resuts.txt file. 
	* 'ruby -Ilib -Ispec -rrspec/autorun AddNewJob/dashboard_spec.rb'
		=> will run 1 test case 
		=> results with displayed in the command line 
		=> use '> results.txt' parameter have the results exported in a resuts.txt file. 
	* 'ruby -Ilib -Ispec -rrspec/autorun AddNewJob/basic_info_spec.rb'
		=> will run 6 test cases
		=> results with displayed in the command line 
		=> use '> results.txt' parameter have the results exported in a resuts.txt file.
	* 'ruby -Ilib -Ispec -rrspec/autorun AddNewJob/details_spec.rb'
		=> will run 17 test cases
		=> results with displayed in the command line 
		=> two test cases will fail because of existing bugs on the TopTal site
		=> use '> results.txt' parameter have the results exported in a resuts.txt file.
	* 'ruby -Ilib -Ispec -rrspec/autorun AddNewJob/required_skills_spec.rb'
		=> will run 5 test cases
		=> results with displayed in the command line 
		=> use '> results.txt' parameter have the results exported in a resuts.txt file.
	* 'ruby -Ilib -Ispec -rrspec/autorun AddNewJob/confirm_spec.rb'
		=> will run 7 test cases
		=> results with displayed in the command line 
		=> use '> results.txt' parameter have the results exported in a resuts.txt file.

HOW TO READ THE RESULTS:
------------------------
Please see below an example of test results:

################################################## results.txt ##################################################
........F.....F..

Failures:

  1) Details Details - start date in the past - this test will fail because of bug
     Failure/Error: expect(test.check_first_warning).to be == 'Invalid date'
     Selenium::WebDriver::Error::TimeOutError:
       timed out after 10 seconds (Unable to locate element: {"method":"xpath","selector":"//body/div[2]/div/div[2]/div/div[5]/div/div[2]"})
     # ./PageObject/abstract.rb:152:in `wait_to_display_xpath'
     # ./PageObject/details.rb:104:in `check_first_warning'
     # AddNewJob/details_spec.rb:187:in `block (2 levels) in <main>'

  2) Details Details - add same language again - will fail because of bug
     Failure/Error: .fill_spoken_languages(spoken_languages)
     Selenium::WebDriver::Error::TimeOutError:
       timed out after 10 seconds
     # ./PageObject/abstract.rb:157:in `wait_for_value_equal'
     # ./PageObject/details.rb:52:in `fill_spoken_languages'
     # AddNewJob/details_spec.rb:350:in `block (2 levels) in <main>'

Finished in 17 minutes 45 seconds (files took 1.02 seconds to load)
17 examples, 2 failures

Failed examples:

rspec  # Details Details - start date in the past - this test will fail because of bug
rspec  # Details Details - add same language again - will fail because of bug
################################################################################################################	
were:
	* the first section '........F.....F..' - represents the short results for all test cases. '.' is added for a passed test, while 'F' is added for a failed test case.
	* we can deduce from here that first 8 tests passed the 9th test failed, 10th to 14th test cases passed the 15th test failed and the 16th and 17th tests passed 
	* the second section give us some details about the failures. In the example above the missing elements are visible.
	* the third section gives some information about the timing need to run the scripts and the total number of tests versus the failed test cases 
	* the forth section displays the failed test cases names  
