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

  describe :previous_link do
    it 'should return disabled if its the first result' do
      result = double('Result', first?: true)

      expect(previous_link(result)).to eq('disabled')
    end

    it 'should return nothing if its not the first result' do
      result = double('Result', first?: false)

      expect(previous_link(result)).to be_nil
    end
  end

  describe :next_link do
    it 'should return disabled if its the last result' do
      result = double('Result', last?: true)

      expect(next_link(result)).to eq('disabled')
    end

    it 'should return nothing if its not the first result' do
      result = double('Result', last?: false)

      expect(next_link(result)).to be_nil
    end

  end
end