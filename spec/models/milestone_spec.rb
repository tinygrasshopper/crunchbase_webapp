require 'spec_helper'

describe Milestone do
  let(:params) { {'id' => 18908,
                  'description' => 'Created',
                  'stoned_year' => 2011,
                  'stoned_month' => 11,
                  'stoned_day' => 2,
                  'source_url' => 'http://techcrunch.com/2011/11/02/rovios-angry-birds-reaches-half-a-billion-downloads/',
                  'source_text' => '',
                  'source_description' => 'First Like is clicked',
                  'stoneable_type' => 'Product',
                  'stoned_value' => nil,
                  'stoned_value_type' => nil,
                  'stoned_acquirer' => nil,
                  'stoneable' => {'name' => 'Angry Birds', 'permalink' => 'angry-birds'}} }
  subject(:milestone) {
    Milestone.new(params)
  }

  it 'should be equal to an equivalent milestone' do
    expect(subject).to eq(Milestone.new(params))
    expect(subject).to eq(Milestone.new(params.symbolize_keys))
    expect(subject).not_to eq(Milestone.new(params.merge(extra: true)))
    expect(subject).not_to eq('a string')
  end

  it 'should have a url' do
    expect(subject.url).to eq('http://techcrunch.com/2011/11/02/rovios-angry-birds-reaches-half-a-billion-downloads/')
  end

  it 'should have a date' do
    expect(subject.date).to eq(Date.new(2011, 11, 2))
  end

  it 'should have a description' do
    expect(subject.description).to eq('Created')
  end

  it 'should have a source description' do
    expect(subject.source_description).to eq('First Like is clicked')
  end

end