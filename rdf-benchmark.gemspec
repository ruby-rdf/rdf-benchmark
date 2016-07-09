#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'rdf-benchmark'
  gem.homepage           = 'http://ruby-rdf.github.com/rdf-benchmark'
  gem.license            = 'Public Domain' if gem.respond_to?(:license=)
  gem.summary            = 'Dataset Generation & Benchmarks for RDF.rb'
  gem.description        = 'Dataset Generation & Benchmarks for RDF.rb'

  gem.authors            = ['Tom Johnson']
  gem.email              = 'public-rdf-ruby@w3.org'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS README.md UNLICENSE VERSION) + Dir.glob('lib/**/*.rb')
  gem.require_paths      = %w(lib)
  gem.has_rdoc           = false

  gem.required_ruby_version      = '>= 2.0.0'
  gem.requirements               = []

  gem.add_runtime_dependency     'rdf',           '~> 2.0'
  gem.add_runtime_dependency     'benchmark-ips'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec',         '~> 3.0'
  gem.add_development_dependency 'yard',          '~> 0.8'

  gem.post_install_message       = nil
end
