ENV['SINATRA_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'capybara/rspec'
require 'capybara/dsl'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RSpecHtmlMatchers
  config.include Capybara::DSL

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 0 # Disabled this to clean up output
  config.order = :random
  Kernel.srand config.seed
end

def app
  # Load the applicaion defined in config.ru
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app
Capybara.javascript_driver = :selenium_headless
