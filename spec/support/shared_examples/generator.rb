shared_examples 'a data generator' do
  describe '#data' do
    it 'yields data' do
      expect { |b| subject.data(&b) }
        .to yield_with_args(be_a(RDF::Enumerable))
    end

    it 'returns an enumerable' do
      expect(subject.data).to be_a RDF::Enumerable
    end

    it 'gives statements with each_statement' do
      expect(subject.data.each_statement.take(10))
        .to contain_exactly(*Array.new(10, be_a(RDF::Statement)))
    end
  end
end
