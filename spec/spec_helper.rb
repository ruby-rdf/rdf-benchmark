# frozen_string_literal: true
require 'bundler/setup'
require 'rdf/benchmark'

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end

Encoding.default_external = Encoding::UTF_8
