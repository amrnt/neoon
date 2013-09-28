require 'spec_helper'

describe Neoon::Model::Config do

  before do
    require 'app/models/topic'
  end

  it 'returns the model config singleton' do
    expect(Topic.neo_model_config.class).to eq Neoon::Model::Config
  end

  context 'properties' do
    it 'stores them' do
      expect(Topic.neo_model_config.properties).not_to be_nil
      expect(Topic.neo_model_config.properties.keys).to eql [ :name, :slug, :created_at ]
    end

    it 'has block' do
      expect(Topic.neo_model_config.properties[:slug][:block]).to be_a(Proc)
    end

    it 'has index' do
      expect(Topic.neo_model_config.properties[:name][:index]).to be_true
    end

    it 'has unique index' do
      expect(Topic.neo_model_config.properties[:slug][:index]).to eql :unique
    end
  end

end
