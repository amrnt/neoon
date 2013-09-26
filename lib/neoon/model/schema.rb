module Neoon
  module Model
    module Schema

      def neo_index_list
        _cypher_query.list_index
      end

      def neo_index_create keys = [], unique = false
        if unique
          _cypher_query.create_constraints(keys).run
        else
          _cypher_query.create_index(keys).run
        end
      end

      def neo_index_drop keys = [], unique = false
        if unique
          _cypher_query.drop_constraints(keys).run
        else
          _cypher_query.drop_index(keys).run
        end
      end

      def neo_index_update_unique
        cl, ck = neo_index_list, neo_schema_index_keys_unique
        return cl if (cl) == (ck)

        neo_index_create(ck - cl, true) unless (ck - cl).empty?
        neo_index_drop(cl - ck, true) unless (cl - ck).empty?
      end

      def neo_index_update
        cl, ck = neo_index_list, neo_schema_index_keys
        return cl if (cl) == (ck)

        neo_index_create(ck - cl) unless (ck - cl).empty?
        neo_index_drop(cl - ck) unless (cl - ck).empty?
      end

      def neo_schema_update
        neo_index_update
        neo_index_update_unique
        neo_index_list
      end

      def neo_schema_index_keys
        neo_model_config.properties.select{ |k, v| v[:index] == true }.keys.sort
      end

      def neo_schema_index_keys_unique
        neo_model_config.properties.select{ |k, v| v[:index] == :unique }.keys.sort
      end

    protected

      def _cypher_query
        Neoon::Cypher::Query.new(self)
      end

    end
  end
end