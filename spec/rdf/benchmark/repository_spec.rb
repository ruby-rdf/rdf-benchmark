# frozen_string_literal: true
require 'spec_helper'
require 'rdf/benchmark/repository'

describe RDF::Benchmark::Repository do
  subject { described_class.new(generator: generator, repository: repository) }

  let(:generator)  { double(:generator, data: data) }
  let(:repository) { RDF::Repository.new }

  let(:data) do
    RDF::Enumerable::Enumerator.new do |yielder|
      loop do
        yielder << RDF::Statement(RDF::URI('http://example.com/1'), 
                                  RDF::URI('http://example.com/2'), 
                                  "3")
      end
    end
  end

  shared_examples "a benchmark" do |method|
    it 'leaves the repository clear' do
      repository.clear

      expect { subject.send(method, **opts) }
        .not_to change { repository.count }
    end

    it 'outputs report to stdout' do
      expect { subject.send(method, **opts) }
        .to output(/Warming.*#{name}.*Calculating.*#{name}.*/m).to_stdout
    end
  end

  describe '#delete!' do
    let(:name) { 'Repository#delete' }
    let(:opts) { { preload: 5_000, time: 0.0001, warmup: 0.0001 } }
    
    it_behaves_like 'a benchmark', :delete!
  end

  describe '#delete_insert!' do
    let(:name) { 'Repository#delete_insert' }
    let(:opts) { { preload: 5_000, time: 0.0001, warmup: 0.0001 } }
    
    it_behaves_like 'a benchmark', :delete_insert!
  end

  describe '#insert!' do
    let(:name) { 'Repository#insert' }
    let(:opts) { { time: 0.0001, warmup: 0.0001 } }

    it_behaves_like 'a benchmark', :insert!
  end

  describe '#repository' do
    it 'returns the repository' do
      expect(subject.repository).to eql repository
    end
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
