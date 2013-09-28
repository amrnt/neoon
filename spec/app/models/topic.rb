class Topic < ActiveRecord::Base
  include Neoon::Node

  neoon do |c|
    c.property :name, :index => true
    c.property :slug, :index => :unique do
      "#{self.id}-#{self.name.underscore}"
    end
    c.property :created_at
  end

end
