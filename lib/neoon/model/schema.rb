module Neoon
  module Model
    module Schema

      def neo_index_list
        Neoon.db.list self.name
      end

      def neo_index_create keys = []
        Neoon.db.create self.name, keys
      end

      def neo_index_drop keys = []
        Neoon.db.drop self.name, keys
      end

      def neo_index_update
        cl = neo_index_list
        ck = neo_node_keys_to_index
        return cl if (cl) == (ck)

        neo_index_create(ck - cl) unless (ck - cl).empty?
        neo_index_drop(cl - ck) unless (cl - ck).empty?
        neo_index_list
      end

      def neo_node_keys_to_index
        neo_model_config.properties.select{ |k, v| v[:index]==true }.keys.sort
      end

    end
  end
end
