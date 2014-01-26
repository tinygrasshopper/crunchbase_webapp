require 'spec_helper'

describe 'search/index.html.erb' do
  context 'companies' do
    it 'should render name' do
      assign(:results, double('SearchResult', products: [], companies: [SearchResultItem.new('name' => 'Facebook'), SearchResultItem.new('name' => 'Google')]))

      render

      expect(rendered).to match /Facebook/
      expect(rendered).to match /Google/
    end

    it 'should render description' do
      assign(:results, double('SearchResult', products: [], companies: [SearchResultItem.new('name' => 'Facebook', 'description' => 'description1')]))

      render

      expect(rendered).to match /description1/
    end
  end

  context 'products' do
    it 'should render name' do
      assign(:results, double('SearchResult', companies: [], products: [SearchResultItem.new('name' => 'Car'), SearchResultItem.new('name' => 'Cycle')]))

      render

      expect(rendered).to match /Cycle/
      expect(rendered).to match /Car/
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