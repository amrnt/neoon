module Neoon
  module Cypher
    module Schema
      module Indexes

        def list_index
          # The only none Cypher query
          Neoon.db.get("/schema/index/#{label}")
            .map{|f| f.send("property-keys")}.flatten.map(&:to_sym).sort
        end

        def create_index(keys = [])
          cypher_query = []
          keys.each do |key|
            cypher_query << "CREATE INDEX ON :#{label}(#{key.to_s.downcase})"
          end
          cypherable(:query => cypher_query)
        end

        def drop_index(keys = [])
          cypher_query = []
          keys.each do |key|
            cypher_query << "DROP INDEX ON :#{label}(#{key.to_s.downcase})"
          end
          cypherable(:query => cypher_query)
        end

      end
    end
  end
end
