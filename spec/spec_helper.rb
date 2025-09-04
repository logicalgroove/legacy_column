require "rubygems"
require "rspec"
require "active_support"
require "active_record"
require "yaml"

config = YAML::load(IO.read(File.join(File.dirname(__FILE__), 'db', 'database.yml')))
db_config = config[ENV['DB'] || 'sqlite3']

if ActiveRecord::VERSION::MAJOR >= 6
  ActiveRecord::Base.establish_connection(db_config)
else
  ActiveRecord::Base.configurations = {'test' => db_config}
  ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])
end

# Load Test Schema into the Database
load(File.dirname(__FILE__) + "/db/schema.rb")

require File.dirname(__FILE__) + '/../init'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
