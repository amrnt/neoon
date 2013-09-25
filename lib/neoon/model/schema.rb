module Neoon
  module Model
    module Schema

      def neo_index_list
        _cypher_query.list_index
      end

      def neo_index_create keys = []
        _cypher_query.create_index(keys).run
      end

      def neo_index_drop keys = []
        _cypher_query.drop_index(keys).run
      end

      def neo_index_update
        cl, ck = neo_index_list, neo_node_keys_to_index
        return cl if (cl) == (ck)

        neo_index_create(ck - cl) unless (ck - cl).empty?
        neo_index_drop(cl - ck) unless (cl - ck).empty?
        neo_index_list
      end

      def neo_node_keys_to_index
        neo_model_config.properties.select{ |k, v| v[:index]==true }.keys.sort
      end

    protected

      def _cypher_query
        Neoon::CypherQuery.new(self)
      end

    end
  end
end