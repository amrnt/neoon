module Neoon
  module Cypher
    class InstanceQuery

      attr_reader :id, :label, :args

      def initialize(object)
        @id     = object.id
        @label  = object.class.name
        @args   = object.neo_node_properties
      end

      def find_node
        cypher_query = <<-CYPHER
          MATCH node:#{label} WHERE node._id = #{id}
          RETURN node
        CYPHER
        cypherable(:query => cypher_query)
      end

      def create_node
        cypher_query = <<-CYPHER
          MERGE (node:#{label} { _id: #{id} })
          ON CREATE node SET node = {props}
          ON MATCH node SET node = {props}
          RETURN node
        CYPHER
        cypherable(:query => cypher_query, :args => {:props => args})
      end
      alias_method :update_node, :create_node
      alias_method :save_node,   :create_node

      def delete_node
        cypher_query = <<-CYPHER
          MATCH node:#{label}
          WHERE node._id = #{id}
          DELETE node
        CYPHER
        cypherable(:query => cypher_query)
      end

    protected

      def cypherable(query)
        Cypher::Handler.new(query)
      end

    end
  end
end
