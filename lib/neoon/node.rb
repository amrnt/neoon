module Neoon
  module Node

    module ClassMethods
    end

    module InstanceMethods
    end

    def self.included(receiver)
      receiver.send :include, Model::Service
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
      Neoon.config.models << receiver
    end

  end
end