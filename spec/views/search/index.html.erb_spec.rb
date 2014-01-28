require 'spec_helper'

describe 'search/index.html.erb' do
  context 'companies' do
    it 'should render name' do
      assign(:results, double('SearchResult', page: 2, products: [], first?: false, last?: false, companies: [double(SearchResultItem, id: 1, image: nil, name: 'Facebook', description: nil),
                                                                                 double(SearchResultItem, id: 1, image: nil, name: 'Google', description: nil)]))

      render

      expect(rendered).to match /Facebook/
      expect(rendered).to match /Google/
    end

    it 'should render description' do
      assign(:results, double('SearchResult', page: 2, products: [], first?: false, last?: false, companies: [double(SearchResultItem, id: 1, image: nil, name: 'Facebook', description: 'description1')]))

      render

      expect(rendered).to match /description1/
    end

    it 'should render image' do
      assign(:results, double('SearchResult', page: 2, products: [], first?: false, last?: false, companies: [double(SearchResultItem, id: 1, image: 'one.jpg', name: nil, description: nil)]))

      render

      expect(rendered).to match /one.jpg/
    end
  end

  context 'products' do
    it 'should render name' do
      assign(:results, double('SearchResult', page: 2, companies: [], first?: false, last?: false, products: [double(SearchResultItem, id: 1, image: nil, name: 'Car', description: nil),
                                                                                 double(SearchResultItem, id: 1, image: nil, name: 'Cycle', description: nil)]))

      render

      expect(rendered).to match /Cycle/
      expect(rendered).to match /Car/
    end

    it 'should render image' do
      assign(:results, double('SearchResult', page: 2, first?: false, last?: false, products: [double(SearchResultItem, id: 1, image: 'one.jpg', name: nil, description: nil)], companies: []))

      render

      expect(rendered).to match /one.jpg/
    end
  end

  context 'pager' do
    it 'should render the previous page link' do
      params[:query]  = 'test'
      assign(:results, double('SearchResult', page: 2, first?: false, last?: false, products: [double(SearchResultItem, id: 1, image: 'one.jpg', name: nil, description: nil)], companies: []))

      render

      expect(rendered).to match /#{CGI::escapeHTML root_path(page: 1, query: 'test')}/
    end

    it 'should render the next page link' do
      params[:query]  = 'test'
      assign(:results, double('SearchResult', page: 2, first?: false, last?: false, products: [double(SearchResultItem, id: 1, image: 'one.jpg', name: nil, description: nil)], companies: []))

      render

      expect(rendered).to match /#{CGI::escapeHTML root_path(page: 3, query: 'test')}/
    end
  end


  it 'should not render companies if results are nil' do
    assign(:results, nil)

    render

    expect(rendered).to_not match /class='companies'/
  end

  it 'should not render products if results are nil' do
    assign(:results, nil)

    render

    expect(rendered).to_not match /class='products'/
  end
end