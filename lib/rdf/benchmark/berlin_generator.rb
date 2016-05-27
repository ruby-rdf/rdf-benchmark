# frozen_string_literal: true
require 'rdf/ntriples'

module RDF::Benchmark
  ##
  # @see http://wifo5-03.informatik.uni-mannheim.de/bizer/berlinsparqlbenchmark/spec/BenchmarkRules/index.html#datagenerator
  class BerlinGenerator
    PATH = './bsbmtools'

    # @!attribute [rw] filename
    # @!attribute [rw] product_factor
    attr_accessor :filename, :product_factor, :format
    
    ##
    # @param filename [String] (default: 'dataset')
    # @param products [Integer] (default: 2000)
    # @param format [String] (default: 'nt')
    def initialize(filename: 'dataset', product_factor: 2000, format: 'nt')
      self.filename       = filename
      self.product_factor = product_factor
      self.format         = format
    end
    
    ##
    # @return [RDF::Reader] a stream of the requested data
    def data(&block)
      filepath = Pathname.new(PATH) + "#{filename}.#{format}"
      generate_data! unless File.exists?(filepath)
      
      RDF::Reader.open(filepath, &block)
    end

    ##
    # Generates the data for this instance, writing it to disk.
    #
    # @return [Boolean] true if successful
    #
    # @note writes the output of the Berlin data generator to stdout
    def generate_data!
      start_dir = Dir.pwd
      
      begin
        Dir.chdir PATH
        system "./generate -pc #{product_factor} -fn #{filename}"
      ensure
        Dir.chdir start_dir
      end
    end
  end
end
