**The gem is not Production Ready™.**

# Neoon [![Build Status](https://travis-ci.org/amrnt/neoon.png?branch=master)](https://travis-ci.org/amrnt/neoon)

A simple Ruby wrapper for Neo4j with focus on Cypher and the features of Neo4j 2.0

---

## Installation

Add this line to your application's Gemfile:

    gem 'neoon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install neoon

## Usage

You can easily install Neo4j in your application path:

```ruby
bundle exec rake neo4j:server:install
```

Then start(stop/restart) the Neo4j server by:

```ruby
bundle exec rake neo4j:server:start

bundle exec rake neo4j:server:stop

bundle exec rake neo4j:server:restart
```

First you have to initialize  a client:

```ruby
ENV["NEO4J_URL"] ||= "http://localhost:7474"

$neo = Neoon.client ENV["NEO4J_URL"]
```

Set configuration:

```ruby
Neoon.configure do |config|
  config.preload_models = true # This will load your models — helps updating the indexed nodes at the (Rails) boot (default: false)
end
```

To query using Cypher:

```ruby
$neo.q('START node=node(*) RETURN node')
```

With ActiveRecord models, initialize Neoon like so (with example of using properties/index):

```ruby
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
```

#### Indexing

This will be used internally to auto index models nodes.

```ruby
Topic.neo_index_list #=> { :name => true, :slug => "UNIQUENESS" }

#
# Sync the indexed nodes as described in each model config. It returns the indexed fields.
# Remember, this will be called on each model on the boot if preload_models set to true.
Topic.neo_schema_update #=> { :name => true, :slug => "UNIQUENESS" }
```

---

### Neoon::Cypher::Query

`Neoon::Cypher::InstanceQuery` should be initialized with an Class name or `label`. You can use `Neoon::Cypher::Query` to manually create indexes, constraints, etc.

```ruby
l = Neoon::Cypher::Query.new('Person')

l.create_index(:name)
# l.drop_index(:name)

l.create_constraint(:username)
# l.drop_constraint(:username)

l.list_indexes                         #=> { :name => true, :username => "UNIQUENESS" }
```

---

### Neoon::Cypher::InstanceQuery

`Neoon::Cypher::InstanceQuery` should be initialized with an object that respond to `id`, `class.name` as it will represent the `label` and `neo_node_properties` as it will represent the `args`.

You can use `Neoon::Cypher::InstanceQuery` to manually create operations on nodes related to an object, etc.

Use it with Struct:

```ruby
Customer = Struct.new(:id, :neo_node_properties)
cus = Customer.new(50, {:name => 'Julie', :address => 'PS'})

c = Neoon::Cypher::InstanceQuery.new(cus)

c.find_node    #=> Return node in Neo4j if already saved
c.create_node  #=> Create object node / or update it
c.delete_node  #=> Remove object node
```

Note that the key of finding nodes in Neo4j is `id` as saved in Neo4j with key `_id`.

Another example on the model we defined above:

```ruby
t = Neoon::Cypher::InstanceQuery.new(Topic.first)

t.find_node    #=> Returns node in Neo4j if already saved
t.create_node  #=> Create object node / or update it
t.delete_node  #=> Remove object node
```

---

**The gem is still at heavy development. More to come!**

## TODO

1. Add inline docs
2. ADD TESTS!!!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/amrnt/neoon/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

