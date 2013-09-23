require 'neoon'
require 'active_record'

ENV["NEO4J_URL"] ||= "http://localhost:7474"
$neo = Neoon.client(ENV["NEO4J_URL"])

ActiveRecord::Base.configurations = YAML::load(IO.read(File.join(File.dirname(__FILE__), 'support/database.yml')))
if defined?(JRUBY_VERSION)
  ActiveRecord::Base.establish_connection('jruby')
else
  ActiveRecord::Base.establish_connection('ruby')
end

require 'support/schema'

RSpec.configure do |config|
  config.mock_with :rspec
end
