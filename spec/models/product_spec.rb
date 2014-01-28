require 'spec_helper'

describe Product do
  it 'should be a crunchbase entity' do
    expect(Product.new({})).to be_an(CrunchbaseEntity)
  end
end
