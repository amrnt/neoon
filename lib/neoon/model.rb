module Neoon
  module Model
    module ClassMethods
      attr_reader :neo_model_config

      def neo_model_config
        @neo_model_config ||= Model::Config.new(self)
      end

      def neoon(opts = {})
        yield(neo_model_config) if block_given?

        opts.each do |key, value|
          raise "No such option #{key} for #{self.name} model" unless neo_model_config.respond_to?("#{key}=")
          neo_model_config.send("#{key}=", value)
        end
      end
    end

    def self.included(receiver)
      receiver.send :include, Model::Node
      receiver.extend         Model::Schema
      receiver.extend         ClassMethods

      receiver.after_save    :neo_save
      receiver.after_destroy :neo_destroy

      Neoon.config.models << receiver
    end
  end
end