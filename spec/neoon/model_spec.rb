require 'spec_helper'

describe Neoon::Model do
  before do
    require 'app/models/topic'
  end

  context Neoon::Model::Config do
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

  context Neoon::Model::Schema do
    before do
      Topic.neo_index_update
    end

    context 'list index' do
      it 'responds to neo_node_keys_to_index' do
        Topic.respond_to?(:neo_node_keys_to_index).should be_true
      end

      it 'returns indexed properties from model config' do
        Topic.neo_node_keys_to_index.should == [:slug]
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

  context Neoon::Model::Service do
    before :each do
      Topic.destroy_all
    end

    context 'save' do
      before do
        @t = Topic.where(:name => 'Apple').first_or_create
      end

      after :all do
        Topic.destroy_all
      end

      it 'responds to neo_save' do
        @t.respond_to?(:neo_save).should be_true
      end

      it 'sets neo_node_properties' do
        @t.neo_node_properties[:db_id].should == @t.id
        @t.neo_node_properties[:name].should == @t.name
        @t.neo_node_properties[:slug].should == "#{@t.id}-#{@t.name.underscore}"
      end

      it 'saves to neo' do
        @t.neo_node.db_id.should == @t.id
      end

      it 'updates to neo after assigning attr and save OR update_attribute()' do
        @t.name = 'MacBook'
        @t.save
        @t.neo_node.name.should == 'MacBook'
        @t.neo_node.db_id.should == @t.id

        @t.update_attribute(:name, 'Technology')
        @t.neo_node.name.should == 'Technology'
        @t.neo_node.db_id.should == @t.id
      end

      it 'has 1 record' do
        Topic.count.should == Neoon.db.q('MATCH n:Topic return n').data.count
        Topic.count.should == 1
      end
    end

    context 'destroy' do
      before do
        @t1 = Topic.where(:name => 'Amr').first_or_create
      end

      after :all do
        Topic.destroy_all
      end

      it 'responds to neo_destroy' do
        @t1.respond_to?(:neo_destroy).should be_true
      end

      it 'has 2 records' do
        topic = Topic.new name: 'Jo'
        topic.save

        Topic.count.should == Neoon.db.q('MATCH n:Topic return n').data.count
        Topic.count.should == 2
      end
    end

  end
end
