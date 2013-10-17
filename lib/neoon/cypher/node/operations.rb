module Neoon
  module Cypher
    module Node
      module Operations

        def find_node(silent_error = true)
          cypher_query = <<-CYPHER
            MATCH node:#{label} WHERE node._id = #{id}
            RETURN node
          CYPHER
          cypherable({:query => cypher_query}, silent_error)
        end
        alias_method :neo_node, :find_node

        def save_node(silent_error = true)
          # since you can't update a constrain with same value
          # we have to remove the node and re-create it
          # destroy_node

          cypher_query = <<-CYPHER
            MERGE (node:#{label} { _id: #{id} })
            ON CREATE node SET node = {props}
            ON MATCH node SET node = {props}
            RETURN node
          CYPHER
          cypherable({:query => cypher_query, :args => {:props => args}}, silent_error)
        end
        alias_method :update_node, :save_node
        alias_method :create_node, :save_node

        def destroy_node(silent_error = true)
          cypher_query = <<-CYPHER
            MATCH node:#{label}
            WHERE node._id = #{id}
            DELETE node
          CYPHER
          cypherable({:query => cypher_query}, silent_error)
        end
        alias_method :delete_node, :destroy_node

      end
    end
  end
end
