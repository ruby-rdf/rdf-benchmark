require 'spec_helper'

describe RDF::Benchmark::BerlinGenerator do
  describe '#data' do
    it 'yields data' do
      expect { |b| subject.data(&b) }.to yield_control
    end

    it 'returns RDF::Reader' do
      expect(subject.data).to be_a RDF::Reader
    end
  end

  describe '#generate_data!' do
    xit 'forces regeneration of data' do
      subject.generate_data!
    end
  end
end
