module Neoon
  module Cypher
    class Handler

      attr_reader :query, :args, :result

      def initialize(hash)
        @query  = hash[:query]
        @args   = hash[:args]
        @result = make_cypher_request(query, args)
      end

      def to_cypher
        [query.gsub(/\s+/, ' ').strip, args]
      end

    protected

      def make_cypher_request(query, args = nil)
        Neoon.db.cypher(query, args)
      end

    end
  end
end
