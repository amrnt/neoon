module Neoon
  class Cypher

    attr_reader :query, :args

    def initialize(hash)
      @query = hash[:query]
      @args  = hash[:args]
    end

    def to_cypher
      if query.is_a?(Array)
        query.map { |q| q.gsub(/\s+/, ' ').strip }
      else
        query.gsub(/\s+/, ' ').strip
      end
    end

    def run
      if query.is_a?(Array)
        query.each { |q| make_cypher_request(q, args) }
      else
        make_cypher_request(query, args)
      end
    end

  protected

    def make_cypher_request(query, args = nil)
      Neoon.db.cypher(query, args)
    end

  end
end
