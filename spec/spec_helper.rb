require "bundler/setup"
require "active_record"
require "factory_bot"
require "faker"
require "database_cleaner/active_record"

Dir[File.join(__dir__, "../app/**/*.rb")].each { |f| require f }

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

load File.join(__dir__, "../db/schema.rb")

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
