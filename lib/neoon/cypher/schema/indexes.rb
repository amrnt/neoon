module Neoon
  module Cypher
    module Schema
      module Indexes

        def list_indexes
          # The only none Cypher query
          idx_keys = Neoon.db.get("/schema/index/#{label}") + Neoon.db.get("/schema/constraint/#{label}")
          idx_keys.reduce({}) { |k, v| k[v.send('property-keys').first.to_sym] = v.type || true; k }
        end

        def create_index(key, silent_error = true)
          cypher_query = "CREATE INDEX ON :#{label}(#{key.to_s.downcase})"
          cypherable({:query => cypher_query}, silent_error)
        end

        def drop_index(key, silent_error = true)
          cypher_query = "DROP INDEX ON :#{label}(#{key.to_s.downcase})"
          cypherable({:query => cypher_query}, silent_error)
        end

      end
    end
  end
end
