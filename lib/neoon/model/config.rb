module Neoon
  module Model
    class Config

      def initialize(klass)
        @klass = klass
      end

      def properties
        @properties ||= {}
      end

      def property(name, *opts, &block)
        self.properties[name] = {:block => block}.merge(opts.first || {}).reject { |k, v| v.nil? }
      end

    end
  end
end
