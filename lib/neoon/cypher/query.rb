module Neoon
  module Cypher
    class Query

      attr_reader :label

      def initialize(klass)
        @label  = klass.is_a?(String) ? klass : klass.name
      end

      include Neoon::Cypher::Schema::Indexes
      include Neoon::Cypher::Schema::Constraints

    protected

      def cypherable(query)
        Cypher::Handler.new(query)
      end

    end
  end
end
