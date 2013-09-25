module Neoon
  class CypherQuery

    attr_reader :label

    def initialize(klass)
      @label  = klass.is_a?(String) ? klass : klass.name
    end

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

  protected

    def cypherable(query)
      Cypher.new(query)
    end
  end
end
