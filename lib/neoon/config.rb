module Neoon
  class Config
    attr_accessor :preload_models

    def models
      @models ||= []
    end
  end
end
