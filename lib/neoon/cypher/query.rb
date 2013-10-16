module Neoon
  module Cypher
    class Query
      include Neoon::Cypher::Schema::Indexes
      include Neoon::Cypher::Schema::Constraints

      attr_reader :label

      def initialize(klass)
        @label  = klass.is_a?(String) ? klass : klass.name
      end

    protected

      def cypherable(query)
        Cypher::Handler.new(query)
      end

    end
  end
end
