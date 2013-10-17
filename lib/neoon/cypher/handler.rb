module Neoon
  module Cypher
    class Handler

      attr_reader :query, :args, :result

      def initialize(hash, silent_error = true)
        @query  = hash[:query]
        @args   = hash[:args]
        @result = if silent_error
          begin
            make_cypher_request(query, args)
          rescue Exception => e
            { :error => e }
          end
        else
          make_cypher_request(query, args)
        end

        if @result[:data] && !@result.data.empty?
          @result = @result.data.first.first.data
        end
      end

      def method_missing(name, *args, &blk)
        if !result.nil? && !result.empty? && result.has_key?(name)
          result[name]
        else
          super(name)
        end
      end

      def to_cypher
        [query.gsub(/\s+/, ' ').strip, args]
      end

      def to_s
        @result
      end

      def inspect
        to_s
      end

    protected

      def make_cypher_request(query, args = nil)
        Neoon.db.cypher(query, args)
      end

    end
  end
end
