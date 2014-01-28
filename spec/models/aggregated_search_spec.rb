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
    product_search_item = double(SearchResultItem)
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, companies: [search_result_item]*4, products: [product_search_item]*20, last?: false))
    expect_to_search(2, 'test', double(SearchResult, companies: [search_result_item]*4, products: [], last?: false))
    expect_to_search(3, 'test', double(SearchResult, companies: [search_result_item]*2, products: [], last?: false))

    search_result = subject.search('test', '1')

    expect(search_result.companies).to eq([search_result_item] * 10)
  end

  it 'should only fetch 10 companies per search item' do
    product_search_item = double(SearchResultItem)
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, companies: [search_result_item]*4, products: [product_search_item]*20, last?: false))
    expect_to_search(2, 'test', double(SearchResult, companies: [search_result_item]*4, products: [], last?: false))
    expect_to_search(3, 'test', double(SearchResult, companies: [search_result_item]*4, products: [], last?: false))

    search_result = subject.search('test', '1')

    expect(search_result.companies).to eq([search_result_item] * 10)
    expect(search_result).not_to be_last
  end


  it 'should fetch company results till the last page' do
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, companies: [search_result_item]*4, products: [], last?: false))
    expect_to_search(2, 'test', double(SearchResult, companies: [search_result_item]*1, products: [], last?: true))

    search_result = subject.search('test', '1')

    expect(search_result.page).to eq(1)
    expect(search_result).to be_last
    expect(search_result.companies).to eq([search_result_item] * 5)
  end


  it 'should fetch results till it has enough products' do
    company_search_item = double(SearchResultItem)
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, products: [search_result_item]*4, companies: [company_search_item]*20, last?: false))
    expect_to_search(2, 'test', double(SearchResult, products: [search_result_item]*4, companies: [], last?: false))
    expect_to_search(3, 'test', double(SearchResult, products: [search_result_item]*2, companies: [], last?: false))

    search_result = subject.search('test', '1')

    expect(search_result.page).to eq(1)
    expect(search_result.products).to eq([search_result_item] * 10)
  end

  it 'should only fetch 10 products per search item' do
    company_search_item = double(SearchResultItem)
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, products: [search_result_item]*4, companies: [company_search_item]*20, last?: false))
    expect_to_search(2, 'test', double(SearchResult, products: [search_result_item]*4, companies: [], last?: false))
    expect_to_search(3, 'test', double(SearchResult, products: [search_result_item]*4, companies: [], last?: false))

    search_result = subject.search('test', '1')

    expect(search_result.page).to eq(1)
    expect(search_result.products).to eq([search_result_item] * 10)
  end


  it 'should fetch product results till the last page' do
    search_result_item = double(SearchResultItem)
    expect_to_search(1, 'test', double(SearchResult, products: [search_result_item]*4, companies: [], last?: false))
    expect_to_search(2, 'test', double(SearchResult, products: [search_result_item]*1, companies: [], last?: true))

    search_result = subject.search('test', '1')
    expect(search_result.page).to eq(1)
    expect(search_result).to be_last
    expect(search_result.products).to eq([search_result_item] * 5)
  end

  it 'should fetch products for the given aggregated page' do
    page_1_companies = double('page_1_companies')
    page_2_companies = double('page_2_companies')
    page_3_companies = double('page_3_companies')
    page_1_products = double('page_1_products')
    page_2_products = double('page_2_products')
    page_3_products = double('page_3_products')

    expect_to_search(1, 'test', double(SearchResult, products: [page_1_products]*6, companies: [page_1_companies]*4, last?: false))
    expect_to_search(2, 'test', double(SearchResult, products: [page_2_products]*6, companies: [page_2_companies]*4, last?: false))
    expect_to_search(3, 'test', double(SearchResult, products: [page_3_products]*4, companies: [page_3_companies]*4, last?: true))

    search_result = subject.search('test', '2')

    expect(search_result.page).to eq(2)
    expect(search_result).to be_last
    expect(search_result.companies).to eq([page_3_companies, page_3_companies])
    expect(search_result.products).to eq([page_2_products, page_2_products, page_3_products, page_3_products, page_3_products, page_3_products])

  end
  it 'should fetch companies for the middle aggregated page' do
    page_1_companies = double('page_1_companies')
    page_2_companies = double('page_2_companies')
    page_3_companies = double('page_3_companies')

    expect_to_search(1, 'test', double(SearchResult, products: [], companies: [page_1_companies]*8, last?: false))
    expect_to_search(2, 'test', double(SearchResult, products: [], companies: [page_2_companies]*8, last?: false))
    expect_to_search(3, 'test', double(SearchResult, products: [], companies: [page_3_companies]*8, last?: true))

    search_result = subject.search('test', '2')

    expect(search_result.page).to eq(2)
    expect(search_result).not_to be_last
    expect(search_result.companies).to eq([page_2_companies, page_2_companies, page_2_companies, page_2_companies, page_2_companies, page_2_companies, page_3_companies, page_3_companies, page_3_companies, page_3_companies])

  end

  it 'should fetch products for the middle aggregated page' do
    page_1_products = double('page_1_products')
    page_2_products = double('page_2_products')
    page_3_products = double('page_3_products')

    expect_to_search(1, 'test', double(SearchResult, companies: [], products: [page_1_products]*8, last?: false))
    expect_to_search(2, 'test', double(SearchResult, companies: [], products: [page_2_products]*8, last?: false))
    expect_to_search(3, 'test', double(SearchResult, companies: [], products: [page_3_products]*8, last?: true))

    search_result = subject.search('test', '2')

    expect(search_result.page).to eq(2)
    expect(search_result).not_to be_last
    expect(search_result.products).to eq([page_2_products, page_2_products, page_2_products, page_2_products, page_2_products, page_2_products, page_3_products, page_3_products, page_3_products, page_3_products])

  end

    it 'should stop making search calls after last page is found' do
    page_1_companies = double('page_1_companies')
    page_2_companies = double('page_2_companies')
    page_3_companies = double('page_3_companies')
    page_1_products = double('page_1_products')
    page_2_products = double('page_2_products')
    page_3_products = double('page_3_products')

    expect_to_search(1, 'test', double(SearchResult, products: [page_1_products]*6, companies: [page_1_companies]*4, last?: false))
    expect_to_search(2, 'test', double(SearchResult, products: [page_2_products]*6, companies: [page_2_companies]*4, last?: false))
    expect_to_search(3, 'test', double(SearchResult, products: [page_3_products]*4, companies: [page_3_companies]*4, last?: true))

    search_result = subject.search('test', '12')

    expect(search_result.page).to eq(12)
    expect(search_result).to be_last
    expect(search_result.companies).to eq([])
    expect(search_result.products).to eq([])

  end

  def expect_to_search(page, term, search_result)
    expect_any_instance_of(Search).to receive(:search).
                                          with(term, page).
                                          and_return(search_result)
  end

end