require 'rails_helper'
require 'spec_helper'
RSpec.configure do |config|

  config.include FeaturesHelpers, type: :feature
  config.use_transactional_fixtures = false #dates not save in db wit gem 'database_cleaner'

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
     DatabaseCleaner.clean
  end
end
