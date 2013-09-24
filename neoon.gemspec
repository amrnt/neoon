# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'neoon/version'

Gem::Specification.new do |spec|
  spec.name          = 'neoon'
  spec.version       = Neoon::VERSION
  spec.authors       = ['Amr Tamimi']
  spec.email         = ['amrnt0@gmail.com']
  spec.description   = 'A simple Ruby wrapper for Neo4j with focus on Cypher'
  spec.summary       = 'A simple Ruby wrapper for Neo4j with focus on Cypher'
  spec.homepage      = 'https://github.com/amrnt/neoon'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version     = '>= 1.9'

  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'faraday_middleware'
  spec.add_runtime_dependency 'multi_json'
  spec.add_runtime_dependency 'hashie'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'activerecord'
  spec.add_development_dependency 'rspec'
end
