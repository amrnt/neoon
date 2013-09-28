module Neoon
  module Cypher
    module Schema
      module Constraints

        def create_constraints(key)
          cypher_query = "CREATE CONSTRAINT ON (node:#{label}) ASSERT node.#{key.to_s.downcase} IS UNIQUE"
          cypherable(:query => cypher_query)
        end

        def drop_constraints(key)
          cypher_query = "DROP CONSTRAINT ON (node:#{label}) ASSERT node.#{key.to_s.downcase} IS UNIQUE"
          cypherable(:query => cypher_query)
        end

      end
    end
  end
end