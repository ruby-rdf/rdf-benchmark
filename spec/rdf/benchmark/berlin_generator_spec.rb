# frozen_string_literal: true
require 'spec_helper'
require 'rdf/benchmark/berlin_generator'

describe RDF::Benchmark::BerlinGenerator do
  it_behaves_like 'a data generator'
  
  describe '.new' do
    it 'supplies default arguments' do
      expect(described_class.new)
        .to have_attributes(filename:       be_a(String),
                            product_factor: be_a(Integer),
                            format:         be_a(String),
                            tool_path:      be_a(String))
    end

    it 'accepts filename' do
      expect(described_class.new(filename: 'blah'))
        .to have_attributes(filename: 'blah')
    end

    it 'accepts format' do
      expect(described_class.new(format: 'blah'))
        .to have_attributes(format: 'blah')
    end

    it 'accepts product_factor' do
      expect(described_class.new(product_factor: 1))
        .to have_attributes(product_factor: 1)
    end
  end

  describe '#generate_data!' do
    xit 'forces regeneration of data' do
      subject.generate_data!
    end
  end
end
