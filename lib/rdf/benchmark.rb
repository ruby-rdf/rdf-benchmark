# frozen_string_literal: true
require 'rdf'
require 'benchmark/ips'
require 'rdf/benchmark/berlin_generator'

module RDF
  module Benchmark
    autoload :Repository, 'rdf/benchmark/repository'

    ##
    # Benchmarks the block
    #
    # @return [Benchmark::IPS::Report]
    def self.benchmark_ips!(name: , time: 5, warmup: 2, &block)
      ::Benchmark.ips do |bm|
        bm.config(:time => time, :warmup => warmup)
        bm.report(name, &block)
      end
    end

    ##
    # Benchmarks the block
    #
    # @return [Benchmark::Report]
    def self.benchmark!(name:)
      ::Benchmark.bmbm do |bm|
        bm.report(name, &block)
      end
    end
  end
end
