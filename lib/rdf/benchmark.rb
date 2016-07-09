# frozen_string_literal: true
require 'rdf'
require 'benchmark/ips'

module RDF
  module Benchmark
    ##
    # Benchmarks the given block, measuring iterations per second.
    #
    # @param name   [String]
    # @param time   [Integer]
    # @param warmup [Integer]
    # @yield runs the block repeatedly as a Benchmark#ips report
    #
    # @return [Benchmark::IPS::Report]
    # @see Benchmark#ips
    def self.benchmark_ips!(name: , time: 5, warmup: 2, &block)
      ::Benchmark.ips do |bm|
        bm.config(:time => time, :warmup => warmup)
        bm.report(name, &block)
      end
    end

    ##
    # Benchmarks a single run of the given block (with warmup).
    #
    # @param name [String]
    # @yield runs the block as a Benchmark#bmbm report
    #
    # @return [Benchmark::Report]
    # @see Benchmark#bmbm
    def self.benchmark!(name:, &block)
      ::Benchmark.bmbm do |bm|
        bm.report(name, &block)
      end
    end
  end
end
