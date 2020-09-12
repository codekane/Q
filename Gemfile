source "https://rubygems.org" do
  gem 'sinatra'
  gem 'require_all'
  gem 'sass'
  gem 'iodine'
  gem 'plezi'


  group :development do
    gem 'guard'
    gem 'guard-rspec', require: false
  end

  group :test, :development do
    gem 'pry'
  end

  group :test do
    gem "rspec"
    gem "rack-test"
    gem "rspec-html-matchers"
    gem "capybara"
    gem "selenium-webdriver"
    gem "puma"
  end
end
