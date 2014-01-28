require 'spec_helper'

describe 'companies/show.html.erb' do
  it 'should render the people of the company' do
    assign(:company, double(Company, overview: 'A game company', people: [double(Person, role: 'CEO', first_name: 'John', last_name: 'Galt', id: 'john-galt')], image: nil, name: nil, url: nil))

    render

    expect(rendered).to match /CEO/
    expect(rendered).to match /John/
    expect(rendered).to match /Galt/
    expect(rendered).to match /http:\/\/www.crunchbase.com\/person\/john-galt/
  end
end