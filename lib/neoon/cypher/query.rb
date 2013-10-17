module Neoon
  module Cypher
    class Query
      include Neoon::Cypher::Schema::Indexes
      include Neoon::Cypher::Schema::Constraints

      attr_reader :label

      def initialize(klass)
        @label  = klass.is_a?(String) ? klass : klass.name
      end

      def method_missing(name, *args, &blk)
        if name.to_s =~ /!$/ && respond_to?(name.to_s[0..-2])
          send(name.to_s[0..-2], *args, false)
        else
          super name
        end
      end

    protected

      def cypherable(query, silent_error = true)
        Cypher::Handler.new(query, silent_error)
      end

    end
  end
end
