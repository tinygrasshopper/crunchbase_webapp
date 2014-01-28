require 'spec_helper'

describe 'products/show.html.erb' do
  it 'should render the milestones of the product' do
    assign(:product, double(Product, name: 'test', image: nil, overview: '', url: '',
                            milestones: [double(Milestone, description: 'description',
                                                date: Date.parse('28/01/2012'),
                                                source_description: 'source description',
                                                url: 'http://example.com/example'
                                         )]))


    render

    expect(rendered).to match /description/
    expect(rendered).to match /2012-01-28/
    expect(rendered).to match /source description/
    expect(rendered).to match /http:\/\/example.com\/example/
  end
end