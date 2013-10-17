module Neoon
  module Cypher
    module Schema
      module Constraints

        def create_constraint(key, silent_error = true)
          cypher_query = "CREATE CONSTRAINT ON (node:#{label}) ASSERT node.#{key.to_s.downcase} IS UNIQUE"
          cypherable({:query => cypher_query}, silent_error)
        end

        def drop_constraint(key, silent_error = true)
          cypher_query = "DROP CONSTRAINT ON (node:#{label}) ASSERT node.#{key.to_s.downcase} IS UNIQUE"
          cypherable({:query => cypher_query}, silent_error)
        end

      end
    end
  end
end