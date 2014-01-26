require 'spec_helper'
describe SearchResultItem do
  subject { described_class.new(name: 'test', description: 'description', namespace: 'namespace', permalink: 'facebook') }

  it 'should return name' do
    expect(subject.name).to eq('test')
  end

  it 'should return description' do
    expect(subject.description).to eq('description')
  end

  it 'should return the namespace' do
    expect(subject.namespace).to eq('namespace')
  end

  it 'should return the id' do
    expect(subject.id).to eq('facebook')
  end

  it 'should be equal to search result item with the same name, description and namespace' do
    expect(subject).to eq(described_class.new(name: 'test', description: 'description', namespace: 'namespace'))
    expect(subject).not_to eq(described_class.new(name: 'test other', description: 'description', namespace: 'namespace'))
    expect(subject).not_to eq(described_class.new(name: 'test', description: 'description other', namespace: 'namespace'))
    expect(subject).not_to eq(described_class.new(name: 'test', description: 'description', namespace: 'namespace other'))
    expect(subject).not_to eq('a string')
  end

  it 'should test if an search item is a company' do
    expect(described_class.new(namespace: 'company')).to be_company
  end

  it 'should test if an search item is a product' do
    expect(described_class.new(namespace: 'product')).to be_product
  end

  it 'should get the first image as the image for the result item' do
    item = described_class.new(image: {'available_sizes' => [
        [[120, 150],
         'assets/images/resized/0033/5817/335817v2-max-150x150.jpg'],
        [[200, 250],
         'assets/images/resized/0033/5817/335817v2-max-250x250.jpg']
    ]})
    expect(item.image).to eq('assets/images/resized/0033/5817/335817v2-max-150x150.jpg')
  end

  it 'should return nil if image absent' do
    item = described_class.new(image: nil)

    expect(item.image).to be_nil
  end
end