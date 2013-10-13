module Neoon
  module Cypher
    module Node
      module Operations

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

      end
    end
  end
end
