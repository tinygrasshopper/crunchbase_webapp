require 'spec_helper'
describe SearchResultItem do
  subject {described_class.new(name: 'test', description: 'description', namespace: 'namespace')}

  it 'should return name' do
    expect(subject.name).to eq('test')
  end

  it 'should return description' do
    expect(subject.description).to eq('description')
  end

  it 'should return the namespace' do
    expect(subject.namespace).to eq('namespace')
  end

  it 'should be equal to search result item with the same name, description and namespace' do
    expect(subject).to eq(described_class.new(name: 'test', description: 'description', namespace: 'namespace'))
    expect(subject).not_to eq(described_class.new(name: 'test other', description: 'description', namespace: 'namespace'))
    expect(subject).not_to eq(described_class.new(name: 'test', description: 'description other', namespace: 'namespace'))
    expect(subject).not_to eq(described_class.new(name: 'test', description: 'description', namespace: 'namespace other'))
    expect(subject).not_to eq('a string')
  end

  it 'should test if an search item is a company' do
    described_class.new(namespace: 'company').company?
  end

  it 'should test if an search item is a product' do
    described_class.new(namespace: 'product').product?
  end
end