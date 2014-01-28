require 'spec_helper'

describe AggregatedSearchResult do
  describe :first? do
    it 'should return true if its the first page' do
      expect(described_class.new('1')).to be_first
    end

    it 'should return false if its not the first page' do
      expect(described_class.new('2')).not_to be_first
    end
  end

  it 'should return the page it was initalized with' do
    result = described_class.new('1')

    expect(result.page).to eq(1)
  end

  it 'should default last to false' do
    result = described_class.new('1')

    expect(result).not_to be_last
  end

  describe :append_companies do
    subject {described_class.new('1')}
    it 'should append to the list of companies' do
      result_item_1 = double(SearchResultItem)
      result_item_2 = double(SearchResultItem)
      result_item_3 = double(SearchResultItem)

      subject.append_companies!([result_item_1])
      subject.append_companies!([result_item_2, result_item_3])

      expect(subject.companies).to eq([result_item_1, result_item_2, result_item_3])
    end

    it 'should only append 10 companies' do
      result_item = double(SearchResultItem)

      subject.append_companies!([result_item]*12)

      expect(subject.companies).to eq([result_item]*10)
    end

    it 'should return the companies not appended' do
      result_item = double(SearchResultItem)

      expect(subject.append_companies!([result_item]*12)).to eq([result_item]*2)
    end

    it 'should return an empty array if all companies are appended' do
      result_item = double(SearchResultItem)

      expect(subject.append_companies!([result_item]*2)).to eq([])
    end
  end

  describe :append_products do
    subject {described_class.new('1')}
    it 'should append to the list of products' do
      result_item_1 = double(SearchResultItem)
      result_item_2 = double(SearchResultItem)
      result_item_3 = double(SearchResultItem)

      subject.append_products!([result_item_1])
      subject.append_products!([result_item_2, result_item_3])

      expect(subject.products).to eq([result_item_1, result_item_2, result_item_3])
    end

    it 'should only append 10 products' do
      result_item = double(SearchResultItem)

      subject.append_products!([result_item]*12)

      expect(subject.products).to eq([result_item]*10)
    end

    it 'should return the products not appended' do
      result_item = double(SearchResultItem)

      expect(subject.append_products!([result_item]*12)).to eq([result_item]*2)
    end

    it 'should return an empty array if all companies are appended' do
      result_item = double(SearchResultItem)

      expect(subject.append_products!([result_item]*2)).to eq([])
    end

  end

  describe :full? do
    it 'returns true if both companies and products have reached limit' do
      result = described_class.new('1')

      item =double(SearchResultItem)
      result.append_products!([item]*12)
      result.append_companies!([item]*12)

      expect(result).to be_full
    end

    it 'returns false if products has not reached limit' do
      result = described_class.new('1')

      item =double(SearchResultItem)
      result.append_products!([item]*8)
      result.append_companies!([item]*12)

      expect(result).not_to be_full
    end

    it 'returns false if companies has not reached limit' do
      result = described_class.new('1')

      item =double(SearchResultItem)
      result.append_products!([item]*12)
      result.append_companies!([item]*8)

      expect(result).not_to be_full
    end
  end

end