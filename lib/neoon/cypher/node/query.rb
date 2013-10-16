module Neoon
  module Cypher
    module Node
      class Query
        include Operations

        attr_reader :id, :label, :args

        def initialize(object)
          @id     = object.id
          @label  = object.class.name
          @args   = object.neo_node_properties.merge(:_id => id)
        end

      protected

        def cypherable(query)
          Cypher::Handler.new(query)
        end

      end
    end
  end
end
