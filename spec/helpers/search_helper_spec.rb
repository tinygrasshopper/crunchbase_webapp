require 'spec_helper'

describe SearchHelper do
  describe :crunchbase_image do
    it 'should return the crunchbase image tag for an item' do
      expect(crunchbase_image('google.img')).to eq("<img src='http://www.crunchbase.com/google.img'/>")
    end

    it 'should render nothing is image is not given' do
      expect(crunchbase_image(nil)).to eq(nil)
    end
  end

  describe :entity_path do
    it 'should return product path for products' do
      expect(entity_path('products', 'name')).to eq(product_path('name'))
    end

    it 'should return company path for products' do
      expect(entity_path('companies', 'name')).to eq(company_path('name'))
    end
  end
end