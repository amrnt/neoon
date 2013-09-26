module Neoon
  module Model
    module Node

      def neo_node
        _cypher_query.find_node.run.data.first.first.data
      end

      def neo_create
        _cypher_query.create_node.run.data
      end
      alias_method :neo_save,   :neo_create
      alias_method :neo_update, :neo_create

      def neo_destroy
        _cypher_query.delete_node.run.data
      end

      def neo_node_properties
        _neo_node.merge({ :_id => self.id })
      end

    protected

      def _cypher_query
        Neoon::Cypher::InstanceQuery.new(self)
      end

      def _neo_node
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