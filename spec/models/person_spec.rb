require 'spec_helper'

describe Person do
  subject(:params) {
    {'title' => 'VP of Engineering',
     'person' => {
         'first_name' => 'Peter',
         'last_name' => 'Deng',
         'permalink' => 'peter-deng'
     }} }
  subject(:person) { Person.new(params) }

  it 'should return the person params' do
    expect(subject.params).to eq(params)
  end

  it 'should return role' do
    expect(subject.role).to eq('VP of Engineering')
  end

  it 'should return first_name' do
    expect(subject.first_name).to eq('Peter')
  end

  it 'should return last_name' do
    expect(subject.last_name).to eq('Deng')
  end

  it 'should return the id' do
    expect(subject.id).to eq('peter-deng')
  end

  context 'equality' do
    it 'should be equal to another person using same params' do
      expect(subject).to eq(Person.new(params))
      expect(subject).to eq(Person.new({title: 'VP of Engineering',
                                        person: {
                                            'first_name' => 'Peter',
                                            'last_name' => 'Deng',
                                            'permalink' => 'peter-deng'
                                        }}))

      expect(subject).to_not eq(Person.new({title: 'VP of Engineering',
                                            person: {
                                                'first_name' => 'Norris',
                                                'last_name' => 'Deng',
                                                'permalink' => 'peter-deng'
                                            }}))
      expect(subject).to_not eq('a string')
    end
  end
end