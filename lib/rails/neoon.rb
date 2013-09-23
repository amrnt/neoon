module Rails
  module Neoon
    extend self

    def load_models(models)
      models.each do |path|
        files = Dir.glob("#{path}/**/*.rb")
        files.sort.each do |file|
          load_model(file.gsub("#{path}/" , "").gsub(".rb", ""))
        end
      end
    end

    def preload_models(app)
      models = app.config.paths["app/models"]
      load_models(models) if ::Neoon.config.preload_models
    end

  private

    def load_model(file)
      begin
        require_dependency(file)
      rescue Exception => e
        puts e.message
      end
    end

  end
end
