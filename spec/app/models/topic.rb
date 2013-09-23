class Topic < ActiveRecord::Base
  include Neoon::Node

  neoon do |c|
    c.property :name
    c.property :slug, :index => true do
      "#{self.id}-#{self.name.underscore}"
    end
  end

end
