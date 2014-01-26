require 'spec_helper'

describe 'companies/show.html.erb' do
  it 'should render the overview from the company' do
    assign(:company, double(Company, overview: '<h1>A</h1> game company', people: [], image: nil, name: nil, url: nil))

    render

    expect(rendered).to match /<h1>A<\/h1> game company/
  end

  it 'should render the people of the company' do
    assign(:company, double(Company, overview: 'A game company', people: [double(Person, role: 'CEO', first_name: 'John', last_name: 'Galt', id: 'john-galt')], image: nil, name: nil, url: nil))

    render

    expect(rendered).to match /CEO/
    expect(rendered).to match /John/
    expect(rendered).to match /Galt/
    expect(rendered).to match /http:\/\/www.crunchbase.com\/person\/john-galt/
  end

  it 'should render the company image' do
    assign(:company, double(Company, image: 'image.jpg', people: [], overview: 'Bla', name: nil, url: nil))

    render

    expect(rendered).to match /image.jpg/
  end

  it 'should render the company crunchbase url' do
    assign(:company, double(Company, image: 'image.jpg', people: [], overview: 'Bla', url: 'http://www.crunchbase.com/company/facebook', name: nil))

    render

    expect(rendered).to match /http:\/\/www.crunchbase.com\/company\/facebook/

  end
end