require 'multi_json'

require 'neoon/version'
require 'neoon/config'
require 'neoon/client/request'
require 'neoon/client/connection'

require 'neoon/cypher/handler'
require 'neoon/cypher/schema/indexes'
require 'neoon/cypher/schema/constraints'
require 'neoon/cypher/query'
require 'neoon/cypher/instance_query'

require 'neoon/model/config'
require 'neoon/model/schema'
require 'neoon/model/node'

require 'neoon/node'


if defined?(Rails)
  require 'neoon/railtie'
end

module Neoon

  class << self
    attr_reader :db

    def client(url)
      @db ||= Client::Connection.new url
    end

    def config
      @config ||= begin
        config = Neoon::Config.new
        config.preload_models = false
        config
      end
    end

    def configure
      yield config
    end
  end

end
