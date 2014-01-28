require 'spec_helper'

describe Product do
  it 'should be a crunchbase entity' do
    expect(Product.new({})).to be_an(CrunchbaseEntity)
  end

  it 'should return the milestones associated with the product' do
    product = Product.new milestones: [{'id' => 18908,
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
                                        'stoneable' => {'name' => 'Angry Birds', 'permalink' => 'angry-birds'}}]

    expect(product.milestones).to eq([Milestone.new({'id' => 18908,
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
                                                     'stoneable' => {'name' => 'Angry Birds', 'permalink' => 'angry-birds'}})])

  end
end
