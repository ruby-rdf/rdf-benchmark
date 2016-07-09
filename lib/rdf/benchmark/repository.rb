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
    # @return [RDF::Enumerator]
    def statements
      @generator.data.each_statement
    end

    ##
    # @param name  [#to_s]
    # @param count [Integer] number of statements to prime for insert
    #
    # @return [Benchmark::IPS::Report]
    def insert!(name: 'insert', count: 100_000)
      inserts = statements.lazy.take(count)
      
      report = RDF::Benchmark.benchmark_ips!(name: name) do
        repository.insert(inserts.next)
      end
      
      return report
    ensure 
      repository.clear
    end

    ##
    # @param name  [#to_s]   the name to give the benchmark report
    # @param count [Integer] number of statements to prime for delete
    #
    # @return [Benchmark::IPS::Report]
    def delete!(name: 'delete', count: 100_000)
      deletes = statements.lazy.take(count)

      deletes.each { |st| repository.insert(st) }

      report = RDF::Benchmark.benchmark_ips!(name: name) do
        repository.delete(deletes.next)
      end
      
      return report
    ensure 
      repository.clear
    end
  end
end
