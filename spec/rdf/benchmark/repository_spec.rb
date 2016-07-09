# frozen_string_literal: true
require 'spec_helper'
require 'rdf/benchmark/repository'


describe RDF::Benchmark::Repository do
  subject { described_class.new(generator: generator, repository: repository) }

  let(:repository) { RDF::Repository.new }

  let(:generator) do
    double(:generator, data: RDF::Reader.for(:ntriples).new(data))
  end

  let(:data) do
    StringIO.new '<http://example.com/1> <http://example.com/2> "3" .' 
  end

  describe '#statements' do
    it 'is enumerable' do
      expect(subject.statements).to respond_to :each
    end

    it 'has statements' do
      expect(subject.statements).not_to be_empty
    end
  end
end
