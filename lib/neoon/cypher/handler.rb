module Neoon
  module Cypher
    class Handler

      attr_reader :query, :args, :result

      def initialize(hash)
        @query  = hash[:query]
        @args   = hash[:args]

        @result = begin
          make_cypher_request(query, args)
        rescue Exception => e
          { :error => e }
        end
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
