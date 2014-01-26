require 'spec_helper'

describe 'companies/show.html.erb' do
  it 'should render the overview from the company' do
    assign(:company, double(Company, overview: 'A game company'))

    render

    expect(rendered).to match /A game company/
  end
end