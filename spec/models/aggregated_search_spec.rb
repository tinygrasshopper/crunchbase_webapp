require 'spec_helper'

describe AggregatedSearch do
  subject { described_class.new }

  it 'should uses Search to search' do
    result = double(SearchResult, companies: [], products: [], last?: true)

    expect_any_instance_of(Search).to receive(:search).
                                          with('test', 1).
                                          and_return(result)
    search_result = subject.search('test', '1')

    expect(search_result.companies).to eq([])
    expect(search_result.products).to eq([])
  end

  it 'should fetch results till it has enough companies' do
    product_search_item =  double(SearchResultItem)
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, companies: [search_result_item]*4, products: [product_search_item]*20, last?: false))
    expect_to_search(2, 'test', double(SearchResult, companies: [search_result_item]*4, products: [], last?: false))
    expect_to_search(3, 'test', double(SearchResult, companies: [search_result_item]*2, products: [], last?: false))

    search_result = subject.search('test', '1')

    expect(search_result.companies).to eq([search_result_item] * 10)
  end

  it 'should only fetch 10 companies per search item' do
    product_search_item =  double(SearchResultItem)
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, companies: [search_result_item]*4, products: [product_search_item]*20, last?: false))
    expect_to_search(2, 'test', double(SearchResult, companies: [search_result_item]*4, products: [], last?: false))
    expect_to_search(3, 'test', double(SearchResult, companies: [search_result_item]*4, products: [], last?: false))

    search_result = subject.search('test', '1')

    expect(search_result.companies).to eq([search_result_item] * 10)
  end


  it 'should fetch company results till the last page' do
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, companies: [search_result_item]*4, products: [], last?: false))
    expect_to_search(2, 'test', double(SearchResult, companies: [search_result_item]*1, products: [], last?: true))

    search_result = subject.search('test', '1')
    expect(search_result.companies).to eq([search_result_item] * 5)
  end


  it 'should fetch results till it has enough products' do
    company_search_item =  double(SearchResultItem)
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, products: [search_result_item]*4, companies: [company_search_item]*20, last?: false))
    expect_to_search(2, 'test', double(SearchResult, products: [search_result_item]*4, companies: [], last?: false))
    expect_to_search(3, 'test', double(SearchResult, products: [search_result_item]*2, companies: [], last?: false))

    search_result = subject.search('test', '1')

    expect(search_result.products).to eq([search_result_item] * 10)
  end

  it 'should only fetch 10 products per search item' do
    company_search_item =  double(SearchResultItem)
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, products: [search_result_item]*4, companies: [company_search_item]*20, last?: false))
    expect_to_search(2, 'test', double(SearchResult, products: [search_result_item]*4, companies: [], last?: false))
    expect_to_search(3, 'test', double(SearchResult, products: [search_result_item]*4, companies: [], last?: false))

    search_result = subject.search('test', '1')

    expect(search_result.products).to eq([search_result_item] * 10)
  end


  it 'should fetch product results till the last page' do
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, products: [search_result_item]*4, companies: [], last?: false))
    expect_to_search(2, 'test', double(SearchResult, products: [search_result_item]*1, companies: [], last?: true))

    search_result = subject.search('test', '1')
    expect(search_result.products).to eq([search_result_item] * 5)
  end

  #it 'should fetch products for the next '


  def expect_to_search(page, term, search_result)
    expect_any_instance_of(Search).to receive(:search).
                                          with(term, page).
                                          and_return(search_result)
  end

end