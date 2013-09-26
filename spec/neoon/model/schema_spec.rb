require 'spec_helper'

describe Neoon::Model::Schema do

  before do
    require 'app/models/topic'
    Topic.neo_schema_update
  end

  context 'list index' do
    it 'responds to neo_schema_index_keys' do
      Topic.respond_to?(:neo_schema_index_keys).should be_true
    end

    it 'returns indexed properties from model config' do
      Topic.neo_schema_index_keys.should == [:slug]
    end

    it 'returns indexed properties from Neo4j' do
      Topic.neo_index_list.should == [:slug]
    end
  end

  context 'create index' do
    it 'responds to neo_index_create' do
      Topic.respond_to?(:neo_index_create).should be_true
    end

    it 'creates indexes for properties' do
      Topic.neo_index_create([:name]).should be_true
      Topic.neo_index_create([:slug]).should be_true
      Topic.neo_index_create([:name, :slug]).should be_true
      Topic.neo_index_list.should == [:name, :slug]
    end

  end

  context 'drop index' do
    it 'responds to neo_index_drop' do
      Topic.respond_to?(:neo_index_create).should be_true
    end

    it 'drops indexes for properties' do
      Topic.neo_index_drop([:name]).should be_true
      Topic.neo_index_drop([:slug]).should be_true
      Topic.neo_index_drop([:name, :slug]).should be_true
      Topic.neo_index_list.should == []
    end
  end

  context 'update index' do
    it 'updates index as in model config' do
      Topic.neo_index_list.should == [:slug]
    end
  end

end
