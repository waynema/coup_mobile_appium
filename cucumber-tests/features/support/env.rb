#encoding: utf-8
require 'rspec/expectations'
require 'appium_lib'
require 'cucumber/ast'
require 'random_data'

class AppiumWorld
end

case ENV['OS']
  when "ios"
    caps = Appium.load_appium_txt file: File.expand_path('../ipad/appium.txt', __FILE__), verbose: true
    report_path = 'features/ireports/'
  when "android"
    caps = Appium.load_appium_txt file: File.expand_path('../android/appium.txt', __FILE__), verbose: true
    report_path = 'features/areports/'
end

Waittime=10

Appium::Driver.new(caps)
Appium.promote_appium_methods AppiumWorld

World do
  AppiumWorld.new
end

Before { $driver.start_driver }
After do |scenario|
  if $driver
    if(scenario.failed?)
      filename = "FAIL-#{scenario.__id__}.png"
      $driver.screenshot(report_path + filename)
      embed(filename, "image/png", "SCREENSHOT")
    end
    $driver.driver_quit
  end
end
