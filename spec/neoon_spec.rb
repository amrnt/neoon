require 'spec_helper'

describe Neoon do

  describe ".config" do

    context "no block given" do
      it "returns the config singleton" do
        Neoon.config.should eq Neoon::config
      end

      it "returns config.preload_models false" do
        Neoon.config.preload_models.should be_false
      end

      it "should have no model" do
        Neoon.config.models.should be_empty
      end
    end

    context "with block given" do
      before do
        Neoon.configure do |c|
          c.preload_models = true
        end
        require 'app/models/topic' # fake loading a model
      end

      after do
        Neoon.configure do |c|
          c.preload_models = false
        end
      end

      it "returns config.preload_models true" do
        Neoon.config.preload_models.should be_true
      end

      it "should have models" do
        Neoon.config.models.should_not be_empty
      end
    end

  end
end
