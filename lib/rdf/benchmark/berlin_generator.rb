# frozen_string_literal: true
require 'rdf/ntriples'

module RDF::Benchmark
  ##
  # @see http://wifo5-03.informatik.uni-mannheim.de/bizer/berlinsparqlbenchmark/spec/BenchmarkRules/index.html#datagenerator
  class BerlinGenerator
    DEFAULT_FILENAME = 'dataset'.freeze
    DEFAULT_FACTOR   = 2_000.freeze
    DEFAULT_FORMAT   = 'nt'.freeze
    DEFAULT_PATH     = './bsbmtools'.freeze

    # @!attribute [rw] filename
    # @!attribute [rw] product_factor
    # @!attribute [rw] format
    # @!attribute [rw] tool_path
    attr_accessor :filename, :product_factor, :format, :tool_path
    
    ##
    # @param filename [String]  (default: 'dataset')
    # @param products [Integer] (default: 2000)
    # @param format   [String]  (default: 'nt')
    def initialize(filename:       DEFAULT_FILENAME, 
                   product_factor: DEFAULT_FACTOR, 
                   format:         DEFAULT_FORMAT, 
                   tool_path:      DEFAULT_PATH)
      self.filename       = filename
      self.product_factor = product_factor
      self.format         = format
      self.tool_path      = tool_path
    end
    
    ##
    # @return [RDF::Reader] a stream of the requested data
    def data(&block)
      filepath = Pathname.new(tool_path) + "#{filename}.#{format}"
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
      
      Dir.chdir tool_path
      system "./generate -pc #{product_factor} -fn #{filename} -fc"
    ensure
      Dir.chdir start_dir
    end
  end
end
