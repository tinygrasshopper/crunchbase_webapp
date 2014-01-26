require 'spec_helper'

describe 'companies/show.html.erb' do
  it 'should render the overview from the company' do
    assign(:company, double(Company, overview: 'A game company', people: []))

    render

    expect(rendered).to match /A game company/
  end

  it 'should render the people of the company' do
    assign(:company, double(Company, overview: 'A game company', people: [double(Person, role: 'CEO', first_name: 'John', last_name: 'Galt')]))

    render

    expect(rendered).to match /CEO/
    expect(rendered).to match /John/
    expect(rendered).to match /Galt/
  end
end