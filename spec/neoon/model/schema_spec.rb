require 'spec_helper'

describe Neoon::Model::Schema do

  before do
    require 'app/models/topic'
    Topic.neo_schema_update
  end

  context 'list index' do
    context 'from model config' do
      it 'responds to .neo_schema_index_keys' do
        expect(Topic).to respond_to(:neo_schema_index_keys)
      end
      it 'returns all indexed properties' do
        expect(Topic.neo_schema_index_keys.keys).to eql [:name, :slug]
      end
      it 'returns indexed properties' do
        expect(Topic.neo_schema_index_keys.select{|_, v| v == true}.keys).to eql [:name]
      end
      it 'returns unique indexed properties' do
        expect(Topic.neo_schema_index_keys.select{|_, v| v == 'UNIQUENESS'}.keys).to eql [:slug]
      end

    end

    context 'from Neo4j' do
      it 'returns all indexed properties' do
        expect(Topic.neo_index_list.keys).to eql [:name, :slug]
      end
      it 'returns indexed properties' do
        expect(Topic.neo_index_list.select{|_, v| v == true}.keys).to eql [:name]
      end
      it 'returns unique indexed properties' do
        expect(Topic.neo_index_list.select{|_, v| v == 'UNIQUENESS'}.keys).to eql [:slug]
      end
    end
  end

  context 'index operation' do
    before :each do
      begin
        Topic.neo_index_drop(:name)
        Topic.neo_index_drop(:slug)
      rescue

      end
    end

    it 'no indexes in Neo4j' do
      expect(Topic.neo_index_list.keys).to eql []
    end

    context 'create index' do
      it 'responds to .neo_index_create' do
        expect(Topic).to respond_to(:neo_index_create)
      end

      it 'creates indexes for properties' do
        expect(Topic.neo_index_create(:name)).to be_true
        expect(Topic.neo_index_list.keys).to eql [:name]

        expect(Topic.neo_index_create(:slug)).to be_true
        expect(Topic.neo_index_list.keys).to eql [:name, :slug]

        expect { Topic.neo_index_create(:name) }.to raise_error Neoon::Error::AlreadyIndexedException
        expect { Topic.neo_index_create(:slug) }.to raise_error Neoon::Error::AlreadyConstrainedException
      end

    end

    context 'drop index' do
      before do
        Topic.neo_index_create(:name)
        Topic.neo_index_create(:slug)
      end

      it 'responds to .neo_index_drop' do
        expect(Topic).to respond_to(:neo_index_drop)
      end

      it 'drops indexes for properties' do
        expect(Topic.neo_index_drop(:name)).to be_true
        expect(Topic.neo_index_list.keys).to eql [:slug]

        expect(Topic.neo_index_drop(:slug)).to be_true
        expect(Topic.neo_index_list.keys).to eql []

        expect { Topic.neo_index_drop(:name) }.to raise_error Neoon::Error::DropIndexFailureException
        expect { Topic.neo_index_drop(:slug) }.to raise_error Neoon::Error::DropIndexFailureException
      end
    end

    context 'update index' do
      before do
        Topic.neo_schema_update
      end

      it 'updates index as in model config' do
        Topic.neo_index_list.keys.should == [:name, :slug]
      end
    end
  end

end
