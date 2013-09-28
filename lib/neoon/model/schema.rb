module Neoon
  module Model
    module Schema

      def neo_index_list
        _cypher_query.list_indexes
      end

      def neo_index_create key
        if neo_schema_index_keys.select { |k,v| v == 'UNIQUENESS' }.include? key
          _cypher_query.create_constraint(key).run
        else
          _cypher_query.create_index(key).run
        end
        true
      end

      def neo_index_drop key
        if neo_index_list[key] == 'UNIQUENESS'
          _cypher_query.drop_constraint(key).run
        else
          _cypher_query.drop_index(key).run
        end
        true
      end

      def neo_index_drop_all
        neo_index_list.each { |k, _| neo_index_drop(k) }
      end

      def neo_index_update
        cl, ck = neo_index_list.to_a, neo_schema_index_keys.to_a
        return cl if cl == ck
        return neo_index_drop_all if ck.empty?

        (cl - ck).each{ |k| neo_index_drop(k.first) } unless (cl - ck).empty?
        (ck - cl).each{ |k| neo_index_create(k.first) } unless (ck - cl).empty?
      end

      def neo_schema_update
        neo_index_update
        neo_index_list
      end

      def neo_schema_index_keys
        neo_model_config.properties.inject({}) do |all, (k, v)|
          all[k] = true if v[:index]
          all[k] = 'UNIQUENESS' if v[:index] == :unique
          all
        end
      end

    protected

      def _cypher_query
        Neoon::Cypher::Query.new(self)
      end

    end
  end
end