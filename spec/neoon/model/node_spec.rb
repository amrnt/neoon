require 'spec_helper'

describe Neoon::Model::Node do

  before :all do
    require 'app/models/topic'
    Topic.neo_schema_update
    Topic.destroy_all
  end

  after :all do
    Topic.destroy_all
  end

  let(:topic) { Topic.where(:name => 'Apple').first_or_create }

  context 'save' do
    it 'responds to .neo_save' do
      expect(topic).to respond_to(:neo_save)
    end

    it 'sets neo_node_properties' do
      expect(topic.neo_node_properties[:_id]).to  eql topic.id
      expect(topic.neo_node_properties[:name]).to eql topic.name
      expect(topic.neo_node_properties[:slug]).to eql "#{topic.id}-#{topic.name.underscore}"
    end

    it 'has same values' do
      expect(topic.neo_node._id).to  eql topic.id
      expect(topic.neo_node.name).to eql topic.name
      expect(topic.neo_node.slug).to eql "#{topic.id}-#{topic.name.underscore}"
    end

    it 'has 1 record' do
      expect(Topic.count).to eql Neoon.db.q('MATCH n:Topic return n').data.count
      expect(Topic.count).to eql 1
    end
  end

  context 'destroy' do
    it 'responds to .neo_destroy' do
      expect(topic).to respond_to(:neo_destroy)
    end

    it 'doesn\'t exist in neo4j' do
      topic.destroy
      expect { topic.neo_node }.to raise_error Neoon::Error::NodeNotFoundException
    end

    it 'has 0 record' do
      expect(Topic.count).to eql Neoon.db.q('MATCH n:Topic return n').data.count
      expect(Topic.count).to eql 0
    end
  end

end
