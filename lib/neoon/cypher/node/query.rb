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
end
