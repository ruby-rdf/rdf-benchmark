# frozen_string_literal: true
module RDF::Benchmark
  class Repository
    # @!attribute [rw] repository
    #   @return [RDF::Repository] the repository to benchmark
    attr_accessor :repository
    
    ##
    # @param generator  [#data]
    # @param repository [RDF::Repository] the repository to benchmark
    def initialize(generator: , repository:)
      @generator  = generator
      @repository = repository
    end

    ##
    # Benchmark {Repository#delete_insert} for individual statements.
    #
    # @param name       [#to_s]   the name to give the benchmark report
    # @param preload    [Integer] number of statements to preload into the 
    #   repository for delete
    # @param options    [Hash<Symbol, Object>]
    #   @see RDF::Benchmark#benchmark_ips
    #
    # @return [Benchmark::IPS::Report] the report for the finished benchmark
    def delete_insert!(name:    'Repository#delete_insert', 
                       preload: 1_000_000, **options)
      inserts = statements.lazy
      deletes = inserts.take(preload)
      deletes.each { |st| repository.insert(st) }

      report = RDF::Benchmark.benchmark_ips!(name: name, **options) do
        repository.delete_insert(deletes.take(10), inserts.take(10))
      end

      return report
    ensure 
      repository.clear
    end

    ##
    # Benchmark {Repository#delete} for individual statements.
    #
    # @param name    [#to_s]   the name to give the benchmark report
    # @param preload [Integer] number of statements to preload into the 
    #   repository for delete
    # @param options [Hash<Symbol, Object>]
    #   @see RDF::Benchmark#benchmark_ips
    #
    # @return [Benchmark::IPS::Report] the report for the finished benchmark
    def delete!(name: 'Repository#delete', preload: 1_000_000, **options)
      deletes = statements.lazy.take(preload)
      deletes.each { |st| repository.insert(st) }
      
      report = RDF::Benchmark.benchmark_ips!(name: name, **options) do
        repository.delete(deletes.next)
      end
      
      return report
    ensure 
      repository.clear
    end

    ##
    # Benchmark {Repository#insert} for individual statements.
    #
    # @param name    [#to_s]
    # @param options [Hash<Symbol, Object>]
    #   @see RDF::Benchmark#benchmark_ips
    #
    # @return [Benchmark::IPS::Report] the report for the finished benchmark
    def insert!(name: 'Repository#insert', **options)
      inserts = statements.lazy

      report = RDF::Benchmark.benchmark_ips!(name: name, **options) do
        repository.insert(inserts.next)
      end
      
      return report
    ensure 
      repository.clear
    end

    ##
    # @return [RDF::Enumerator]
    def statements
      @generator.data.each_statement
    end
  end
end
