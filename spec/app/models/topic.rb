class Topic < ActiveRecord::Base
  include Neoon::Model

  neoon do |c|
    c.property :name, :index => true
    c.property :slug, :index => :unique do
      "#{self.id}-#{self.name.parameterize}"
    end
    c.property :created_at
  end

end
