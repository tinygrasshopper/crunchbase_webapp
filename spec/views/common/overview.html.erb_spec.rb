require 'spec_helper'

describe 'common/overview.html.erb' do
  it 'should render the overview from the company' do
    entity = double(Company, overview: '<h1>A</h1> game company', people: [], image: nil, name: nil, url: nil)

    render partial: 'common/overview', locals: {entity: entity}

    expect(rendered).to match /<h1>A<\/h1> game company/
  end

  it 'should render the company image' do
    entity = double(Company, image: 'image.jpg', people: [], overview: 'Bla', name: nil, url: nil)

    render partial: 'common/overview', locals: {entity: entity}

    expect(rendered).to match /image.jpg/
  end

  it 'should render the company crunchbase url' do
    entity = double(Company, image: 'image.jpg', people: [], overview: 'Bla', url: 'http://www.crunchbase.com/company/facebook', name: nil)
    render partial: 'common/overview', locals: {entity: entity}

    expect(rendered).to match /http:\/\/www.crunchbase.com\/company\/facebook/

  end
end
