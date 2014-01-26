require 'spec_helper'

describe CompaniesHelper do
  it 'should generate the crunchbase person url from id' do
    expect(crunchbase_person_url('mark')).to eq('http://www.crunchbase.com/person/mark')
  end
end