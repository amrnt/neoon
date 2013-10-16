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

        def save_node
          # since you can't update a constrain with same value
          # we have to remove the node and re-create it
          # other way ???
          delete_node unless (label.constantize.respond_to?(:neo_schema_index_keys) ? label.constantize.neo_schema_index_keys : Neoon::Cypher::Query.new(label).list_indexes).select{|k,v| v=='UNIQUENESS'}.empty?

          cypher_query = <<-CYPHER
            MERGE (node:#{label} { _id: #{id} })
            ON CREATE node SET node = {props}
            ON MATCH node SET node = {props}
            RETURN node
          CYPHER
          cypherable(:query => cypher_query, :args => {:props => args})
        end
        alias_method :update_node, :save_node
        alias_method :create_node, :save_node

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
