Given(/^I have App running with appium$/) do
end

When (/^I wait to debug$/) do
  require 'pry'
  binding.pry
end

When(/^I click "(.*?)"$/) do |data|
  if ENV['OS'] == "ios"
    wait_for_element(:name, data) {|btn|btn.click}
  end
end

When(/^I tap "(.*?)"$/) do |data|
  wait_for_element(:name, data) {|btn|btn.click}
end

When(/^I take an Android snapshot$/) do
  if something_present("Take this Snapshot")
    wait_for_element(:name, "Take this Snapshot") {|btn|btn.click}
  else 
    wait_for_element(:name, "Take") {|btn|btn.click}
  end
end
  
When(/^I tap xpath "(.*?)"$/) do |data|
  wait_for_element(:xpath, data) {|btn|btn.click}
end

When(/^I tap (\d+),(\d+)$/) do |x, y|
  sleep 4
  driver.execute_script 'mobile: tap', :x => x, :y => y
end

When(/^I wait and tap "(.*?)"$/) do |data|
  sleep 2
  wait_for_element(:name, data) {|btn|btn.click}
end

When(/^I wait and tap xpath "(.*?)"$/) do |data|
  sleep 2
  wait_for_element(:xpath, data) {|btn|btn.click}
end

Then(/^I sleep (\d+)$/) do |second|
  sleep second.to_i
end

When(/^I tap button (\d+)$/) do |number|
  wait{button(number.to_i)}.click
end

Then(/^I tap button "(.*?)"$/) do |name|
  wait{button_exact(name)}.click
end

When(/^I tap text (\d+)$/) do |number|
  wait{text_exact(number.to_i)}.click
end

Then(/^I tap text "(.*?)"$/) do |name|
  wait{text_exact(name)}.click
end

When(/^I tap radio button (\d+)$/) do |number|
  click_radio_button (number)
end

When(/^I tap radio button$/) do
  if something_present("Radio Button")
    wait_for_element(:name, 'Radio Button') {|btn|btn.click}
  else
    driver.swipe(400, 600, 400, 100, 1000)
    wait_for_element(:name, 'Radio Button') {|btn|btn.click}
  end
end

Then(/^I should see "(.*?)" button disable$/) do |data|
  wait_for_element(:name, data){}
  expect(driver.find_element(:name, data).enabled?).to be false
end

Then(/^I should see "(.*?)" button enable$/) do |data|
  wait_for_element(:name, data){}
  expect(driver.find_element(:name, data).enabled?).to be true
end

Then(/^I should wait for "(.*?)" button enable$/) do |data|
  wait_for_element_enabled(:name, data){}
end

Then(/^I should see for "(.*?)" button enable$/) do |data|
  wait_for_element_enabled(:name, data){}
end

Then(/^I should see "(.*?)"$/) do |text|
    wait_for_element(:name, text) {}
    foundText = driver.find_element(:name, text)
    expect(foundText.enabled? || foundText.displayed?).to be true
end

Then(/^I should not see "(.*?)"$/) do |text|
  expect(something_present(text)).to be false
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |editbox, data|
  driver.find_element(:name, editbox).send_keys data
end

When(/^I fill in textfield "(.*?)" with "(.*?)"$/) do |editbox, data|
  textfield_exact(editbox).send_keys data
end

When(/^I fill in textfield (\d+) with "(.*?)"$/) do |editbox, data|
  textfield_exact(editbox.to_i).send_keys data
end

When(/^I fill in xpath "(.*?)" with "(.*?)"$/) do |editbox, data|
  driver.find_element(:xpath, editbox).send_keys data
end

When(/^I clear and fill in "(.*?)" with "(.*?)"$/) do |editbox, data|
  editBox = driver.find_element(:name, editbox)
  editBox.clear
  editBox.send_keys data
end

Given(/^I login as "(.*?)"$/) do |username|
  	login username, "password"
end

Given(/^I login using "(.*?)" and "(.*?)"$/) do |username, password|
  	login username, password
end

Then(/^I should see message$/) do
    expect(text(@msg).enabled?).to be true
end

When(/^I wait for "(.*?)"$/) do |elementname|
  if ENV['OS'] == "ios"
  	wait_for_element(:name, elementname){}
  end
end

When(/^I enter "(.*?)"$/) do |something|
  driver.keyboard.send_keys something
end

def wait_for_element(*args, &block)
	element = nil
	wait = Selenium::WebDriver::Wait.new(:timeout => Waittime)
	wait.until { element = driver.find_element(*args) }
	yield element
end

def wait_for_element_enabled(*args, &block)
	element = nil
	wait = Selenium::WebDriver::Wait.new(:timeout => Waittime)
	wait.until { 
		element = driver.find_element(*args)
		element.enabled?
	}
	yield element
end

def something_present(text)
begin
  @wait = Selenium::WebDriver::Wait.new(:timeout => Waittime)
  @wait.until { driver.find_element(:name, text).displayed? }
  @something_displayed = driver.find_element(:name, text).displayed?
rescue
  @something_displayed = false
end
@something_displayed
end

def login(username, password)
  case ENV['OS']
    when "ios"   
  
    when "android"
      driver.find_element(:id, "instanceView").send_key "dashmaster12-0-9.coupadev.com"
      driver.find_element(:id, "continueButton").click
      wait_for_element(:id, "username"){}
      driver.find_element(:id, "username").clear
      driver.find_element(:id, "username").send_key username
      driver.find_element(:id, "password").clear
      driver.find_element(:id, "password").send_key password+"\n"
      driver.find_element(:id, "loginButton").click
      wait_for_element(:id, "home"){}
  end
end
