require 'spec_helper'

describe Company do
  context 'find' do
    it 'should use the crunchbase client to perform the search' do
      expect_any_instance_of(CrunchbaseClient).to receive(:get).with('company', 'facebook').and_return(name: 'Facebook', overview: 'A social network')

      company = Company.find 'facebook'

      expect(company).to eq(Company.new(name: 'Facebook', overview: 'A social network'))
    end
  end

  subject(:company) { Company.new(x: :a) }
  context 'equality' do
    it 'should be equal to a company initalized with the same params' do
      expect(company).to eq(Company.new(x: :a))
      expect(company).not_to eq(Company.new(x: :b))
      expect(company).not_to eq('a string')
    end
  end

  it 'should return params' do
    expect(company.params).to eq(x: :a)
  end
end