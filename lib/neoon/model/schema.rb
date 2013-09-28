module Neoon
  module Model
    module Schema

      def neo_index_list
        _cypher_query.list_indexes
      end

      def neo_index_create key
        index_key      = ([key] & neo_schema_index_keys).first
        index_uniq_key = ([key] & neo_schema_index_keys_unique).first

        _cypher_query.create_index(index_key).run if index_key
        _cypher_query.create_constraints(index_uniq_key).run if index_uniq_key
        true
      end

      def neo_index_drop key
        index_key      = ([key] & neo_schema_index_keys).first
        index_uniq_key = ([key] & neo_schema_index_keys_unique).first

        _cypher_query.drop_index(index_key).run if index_key
        _cypher_query.drop_constraints(index_uniq_key).run if index_uniq_key
        true
      end

      def neo_index_update
        cl, ck = neo_index_list.keys, neo_schema_index_keys + neo_schema_index_keys_unique
        return cl if cl == ck

        (ck - cl).each{ |k| neo_index_create(k) } unless (ck - cl).empty?
        (cl - ck).each{ |k| neo_index_drop(k) } unless (cl - ck).empty?
      end

      def neo_schema_update
        neo_index_update
        neo_index_list.keys
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