require 'spec_helper'

describe Neoon::Model::Node do

  before :each do
    require 'app/models/topic'
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
