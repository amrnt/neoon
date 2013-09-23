module Neoon
  module Model
    module Service

      module ClassMethods
        attr_reader :neo_model_config

        def neo_model_config
          @neo_model_config ||= Neoon::Model::Config.new(self)
        end

        def neoon(opts = {})
          yield(neo_model_config) if block_given?

          opts.each do |key, value|
            raise "No such option #{key} for #{self.name} model" unless neo_model_config.respond_to?("#{key}=")
            neo_model_config.send("#{key}=", value)
          end
        end
      end

      module InstanceMethods
        def neo_node_props
          neo_node.merge({ :db_id => self.id })
        end

        def neo_save
          cypher_query = <<-CYPHER
            MERGE (node:#{self.class.name} { db_id: #{self.id} })
            ON CREATE node SET node = {props}
            ON MATCH node SET node = {props}
            RETURN node
          CYPHER
          Neoon.db.q(cypher_query, { :props => neo_node_props })
        end

        def neo_destroy
          cypher_query = <<-CYPHER
          CYPHER
          Neoon.db.q(cypher_query)
        end

      protected

        def neo_node
          return {} unless self.class.neo_model_props
          hash = self.class.neo_model_props.inject({}) do |all, (field, block)|
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

      def self.included(receiver)
        receiver.extend         ClassMethods
        receiver.extend         Schema
        receiver.send :include, InstanceMethods

        receiver.after_save :neo_save
      end

    end
  end
end
