# Gemfile
source 'https://rubygems.org'
ruby '>= 2.5.3'

gem 'cocoapods'
gem 'cocoapods-githooks'

gem "fastlane"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)

