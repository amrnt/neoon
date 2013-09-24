**The gem is not Production Ready™.**

# Neoon [![Build Status](https://travis-ci.org/amrnt/neoon.png?branch=master)](https://travis-ci.org/amrnt/neoon)

A simple Ruby wrapper for Neo4j with focus on Cypher and the features of Neo4j 2.0

#### Inspired by [Neoid](https://github.com/elado/neoid)

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

To your ActiveRecord model, initialize Neoon like so (with example of using properties/index):

```ruby
class Topic < ActiveRecord::Base

  include Neoon::Node

  neoon do |c|
    c.property :name
    c.property :slug, :index => true do
      "#{self.id}-#{self.name.underscore}"
    end
  end

end
```

### Indexing

This will be used internally to auto indexing models nodes.

```ruby
Neoon.db.list 'Topic' #=> [:slug]

Neoon.db.create 'Topic', [:name, ...]

Neoon.db.drop 'Topic', [:name, ...]

# Alternativly

Topic.neo_index_list #=> [:slug]

Topic.neo_index_create [:name, ...]

Topic.neo_index_drop [:name, ...]

# Sync the indexed nodes as described in each model config. It returns the indexed fields.
# Remember, this will be called on each model on the boot if preload_models set to true.
Topic.neo_index_update #=> [:slug]
```

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
