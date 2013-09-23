ActiveRecord::Schema.define :version => 0 do
  create_table :topics do |t|
    t.string :name

    t.timestamps
  end
end
