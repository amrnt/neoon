require 'spec_helper'

describe Neoon::Model::Config do

  before do
    require 'app/models/topic'
  end

  context 'Model' do
    it 'responds to neoon' do
      Topic.respond_to?(:neoon).should be_true
    end

    it 'responds to neo_model_config' do
      Topic.respond_to?(:neo_model_config).should be_true
    end
  end

  context 'properties' do
    it 'stores them' do
      Topic.neo_model_config.properties.should_not be_nil
      Topic.neo_model_config.properties.keys.should == [ :name, :slug ]
    end

    it 'has block' do
      Topic.neo_model_config.properties[:slug][:block].should be_a(Proc)
    end

    it 'has index' do
      Topic.neo_model_config.properties[:slug][:index].should be_true
    end
  end

end
