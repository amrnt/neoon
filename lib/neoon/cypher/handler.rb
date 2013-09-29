module Neoon
  module Cypher
    class Handler

      attr_reader :query, :args

      def initialize(hash)
        @query = hash[:query]
        @args  = hash[:args]
      end

      def to_cypher
        query.gsub(/\s+/, ' ').strip
      end

      def run
        make_cypher_request(query, args)
      end

    protected

      def make_cypher_request(query, args = nil)
        Neoon.db.cypher(query, args)
      end

    end
  end
end
