module Neoon
  module Model
    module Node

      def neo_node
        node = cypher_query.find_node.result
        if node.data && node.data.empty?
          raise Neoon::Error::NotFoundError.new({}, "Cannot find node with id [#{cypher_query.id}] in database.")
        end
        node
      end

      def neo_save
        cypher_query.save_node
      end
      alias_method :neo_create, :neo_save
      alias_method :neo_update, :neo_save

      def neo_destroy
        cypher_query.destroy_node
      end

      def neo_node_properties
        build_neo_node.merge(:_id => self.id)
      end

    protected

      def cypher_query
        Neoon::Cypher::Node::Query.new(self)
      end

      def build_neo_node
        return {} unless self.class.neo_model_config.properties
        hash = self.class.neo_model_config.properties.inject({}) do |all, (field, block)|
          all[field] = if block[:block]
            instance_eval(&block[:block])
          else
            self.send(field) rescue (raise "No field #{field} for #{self.class.name}")
          end
          all
        end
        hash.reject { |k, v| v.nil? }
      end

    end
  end
end