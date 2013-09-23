require 'rails'
require 'rails/neoon'

module Rails
  module Neoon
    class Railtie < ::Rails::Railtie

      rake_tasks do
        load 'neoon/tasks/server.rake'
        load 'neoon/tasks/database.rake'
      end

      initializer "neoon.neo_index_update" do
        config.after_initialize do
          ::Neoon.config.models.each(&:neo_index_update)
        end
      end

      initializer "neoon.preload_models" do |app|
        config.to_prepare do
          Rails::Neoon.preload_models(app)
        end
      end

    end
  end
end
