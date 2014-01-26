require 'spec_helper'

describe 'search/index.html.erb' do
  it 'should render name' do
    assign(:results, double('SearchResult', results: [{'name' => 'Facebook'}, {'name' => 'Google'}]))

    render

    expect(rendered).to match /Facebook/
    expect(rendered).to match /Google/
  end

  it 'should render description' do
    assign(:results, double('SearchResult', results: [{'name' => 'Facebook', 'description' => 'description1'}]))

    render

    expect(rendered).to match /description1/
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