ENV['ENVIRONMENT'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'setup_test_database'
require 'capybara'
require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'

Capybara.app = MakersBNB
Capybara.default_driver = :selenium
Capybara.server = :webrick



SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  # SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

RSpec.configure do |config|

  config.before(:each) do
    setup_test_database
  end
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

end
