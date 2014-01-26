describe SearchResult do
  describe 'equality' do
    subject { described_class.new(page: 1, results: [first_name: 'test', last_name: 'test2']) }
    it 'should be equal to a search item with the same result and page' do
      expect(subject).to eq(SearchResult.new(page: 1, results: [first_name: 'test', last_name: 'test2']))
      expect(subject).not_to eq(SearchResult.new(page: 2, results: [first_name: 'test', last_name: 'test2']))
      expect(subject).not_to eq(SearchResult.new(page: 1, results: [first_name: 'test2', last_name: 'test2']))
    end
  end

  context 'results' do
    it 'should return the search results, when hash has symbol keys' do
      search_result = described_class.new(page: 1, results: [first_name: 'test', last_name: 'test2'])
      expect(search_result.results).to eq(['first_name' => 'test', 'last_name' => 'test2'])
    end

    it 'should return the search results, when hash has string key' do
      search_result = described_class.new('page' => 1, 'results' => [first_name: 'test', last_name: 'test2'])
      expect(search_result.results).to eq(['first_name' => 'test', 'last_name' => 'test2'])
    end
  end

  context 'companies' do
    it 'should filter out and return only companies from results' do
      search_result = described_class.new(page: 1, results: [{name: 'facebook', namespace: 'company'},
                                                             {name: 'cycle', namespace: 'product'}])

      expect(search_result.companies).to eq([{'name' => 'facebook', 'namespace' => 'company'}])

    end
  end

  context 'products' do
    it 'should filter out and return only companies from results' do
      search_result = described_class.new(page: 1, results: [{name: 'facebook', namespace: 'company'},
                                                             {name: 'cycle', namespace: 'product'}])

      expect(search_result.products).to eq([{'name' => 'cycle', 'namespace' => 'product'}])

    end
  end
end