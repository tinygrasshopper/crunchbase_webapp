require 'spec_helper'

describe Company do
  context 'people' do
    it 'should return the people associated' do
      company = Company.new relationships: [{
                                                'is_past' => false,
                                                'title' => 'VP of Engineering',
                                                'person' => {
                                                    'first_name' => 'Peter',
                                                    'last_name' => 'Deng',
                                                    'permalink' => 'peter-deng'
                                                }
                                            }]

      expect(company.people).to eq([Person.new({
                                                   'is_past' => false,
                                                   'title' => 'VP of Engineering',
                                                   'person' => {
                                                       'first_name' => 'Peter',
                                                       'last_name' => 'Deng',
                                                       'permalink' => 'peter-deng'
                                                   }
                                               })])
    end
  end

  it 'should be a crunchbase entity' do
    expect(Company.new({})).to be_an(CrunchbaseEntity)
  end
end