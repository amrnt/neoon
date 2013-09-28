require 'spec_helper'

describe Neoon::Config do

  context 'no block given' do
    it 'returns the config singleton' do
      expect(Neoon.config.class).to eq Neoon::Config
    end

    it 'returns config.preload_models false' do
      expect(Neoon.config.preload_models).to be_false
    end

    it 'should have no model' do
      expect(Neoon.config.models).to be_empty
    end
  end

  context 'with block given' do
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

    it 'returns config.preload_models true' do
      expect(Neoon.config.preload_models).to be_true
    end

    it 'should have models' do
      expect(Neoon.config.models).not_to be_empty
    end
  end

end
