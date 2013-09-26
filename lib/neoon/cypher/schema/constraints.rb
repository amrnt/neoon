module Neoon
  module Cypher
    module Schema
      module Constraints

        def create_constraints(keys = [])
          cypher_query = []
          keys.each do |key|
            cypher_query << "CREATE CONSTRAINT ON (node:#{label}) ASSERT node.#{key.to_s.downcase} IS UNIQUE"
          end
          cypherable(:query => cypher_query)
        end

        def drop_constraints(keys = [])
          cypher_query = []
          keys.each do |key|
            cypher_query << "DROP CONSTRAINT ON (node:#{label}) ASSERT node.#{key.to_s.downcase} IS UNIQUE"
          end
          cypherable(:query => cypher_query)
        end

      end
    end
  end
end