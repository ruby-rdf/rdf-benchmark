# frozen_string_literal: true
module RDF::Benchmark
  class Repository
    # @!attribute [rw] repository
    #   @return [RDF::Repository] the repository to benchmark
    attr_accessor :repository
    
    ##
    # @param generator [#data]
    def initialize(generator: , repository:)
      @generator  = generator
      @repository = repository
    end

    ##
    # @return [Enumerable]
    def statements
      @generator.data.each_statement
    end

    ##
    # @return [Benchmark::IPS::Report]
    def insert!
      sts = statements(1_000_000).to_enum

      report = RDF::Benchmark.benchmark_ips!(name: 'insert') do
        repository.insert(sts.next)
      end
      repository.clear
      
      report
    end

    def delete!
      repository.insert(statements)

      deletes = statements
      report = RDF::Benchmark.benchmark_ips!(name: 'insert') do
        repository.delete(deletes.next)
      end
      repository.clear
      
      report
    end
  end
end
