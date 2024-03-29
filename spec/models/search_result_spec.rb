require 'spec_helper'
describe SearchResult do
  describe 'equality' do
    subject { described_class.new(page: 1, results: [name: 'test']) }

    it 'should be equal to a search item with the same result and page' do
      expect(subject).to eq(SearchResult.new(page: 1, results: [name: 'test']))
      expect(subject).not_to eq(SearchResult.new(page: 2, results: [name: 'test']))
      expect(subject).not_to eq(SearchResult.new(page: 1, results: [name: 'test2']))
    end
  end

  context 'results' do
    it 'should return the search results, when hash has symbol keys' do
      search_result = described_class.new(page: 1, results: [name: 'test'])
      expect(search_result.results).to eq([SearchResultItem.new('name' => 'test')])
    end

    it 'should return the search results, when hash has string key' do
      search_result = described_class.new('page' => 1, 'results' => [name: 'test'])
      expect(search_result.results).to eq([SearchResultItem.new(name: 'test')])
    end
  end

  context 'companies' do
    it 'should filter out and return only companies from results' do
      search_result = described_class.new(page: 1, results: [{name: 'facebook', namespace: 'company'},
                                                             {name: 'cycle', namespace: 'product'}])

      expect(search_result.companies).to eq([SearchResultItem.new('name' => 'facebook', 'namespace' => 'company')])

    end
  end

  context 'products' do
    it 'should filter out and return only companies from results' do
      search_result = described_class.new(page: 1, results: [{name: 'facebook', namespace: 'company'},
                                                             {name: 'cycle', namespace: 'product'}])

      expect(search_result.products).to eq([SearchResultItem.new('name' => 'cycle', 'namespace' => 'product')])

    end
  end

  context 'page' do
    it 'should return the page number' do
      search_result = described_class.new(page: '1', results: [{name: 'facebook', namespace: 'company'},
                                                             {name: 'cycle', namespace: 'product'}])

      expect(search_result.page).to eq(1)
    end
  end

  context 'first?' do
    it 'should be true if its the first page' do
      search_result = described_class.new(page: '1', results: [])

      expect(search_result).to be_first
    end

    it 'should be false if its not the first page' do
      search_result = described_class.new(page: '2', results: [])

      expect(search_result).not_to be_first
    end
  end

  context 'last?' do
    it 'should be true if its the last page' do
      search_result = described_class.new(page: '3', total: '21', results: [])

      expect(search_result).to be_last
    end

    it 'should be false if its not the last page' do
      search_result = described_class.new(page: '1', total: '21', results: [])

      expect(search_result).not_to be_last
    end
  end
end