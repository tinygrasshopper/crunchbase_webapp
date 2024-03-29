require 'spec_helper'

describe CrunchbaseEntity do
  context 'find' do
    it 'should use the crunchbase client to perform the search companies' do
      expect_any_instance_of(CrunchbaseClient).to receive(:get).with('company', 'facebook').and_return(name: 'Facebook', overview: 'A social network')

      company = Company.find 'facebook'

      expect(company).to eq(Company.new(name: 'Facebook', overview: 'A social network'))
    end
    it 'should use the crunchbase client to perform the search products' do
      expect_any_instance_of(CrunchbaseClient).to receive(:get).with('product', 'angry').and_return(name: 'Angry', overview: 'A game')

      company = Product.find 'angry'

      expect(company).to eq(Product.new(name: 'Angry', overview: 'A game'))
    end
  end


  subject(:params) { {'x' => :a, 'overview' => 'A social network', 'name' => 'Facebook', 'crunchbase_url' => 'http://www.crunchbase.com/company/facebook'} }
  subject(:company) { CrunchbaseEntity.new(params) }
  context 'equality' do
    it 'should be equal to a company initalized with the same params' do
      expect(company).to eq(CrunchbaseEntity.new(params))
      expect(company).not_to eq(CrunchbaseEntity.new(x: :b))
      expect(company).not_to eq('a string')
    end
  end

  context 'image' do
    it 'should return the last image' do
      company = described_class.new(image: {'available_sizes' => [
          [[120, 150],
           'assets/images/resized/0033/5817/335817v2-max-150x150.jpg'],
          [[200, 250],
           'assets/images/resized/0033/5817/335817v2-max-250x250.jpg']
      ]})
      expect(company.image).to eq('assets/images/resized/0033/5817/335817v2-max-250x250.jpg')
    end

    it 'should return nil if image absent' do
      company = described_class.new(image: nil)

      expect(company.image).to be_nil
    end
  end

  it 'should return params' do
    expect(company.params).to eq(params)
  end

  it 'should return url' do
    expect(company.url).to eq('http://www.crunchbase.com/company/facebook')
  end

  it 'should return the overview from the params' do
    expect(company.overview).to eq('A social network')
  end


  it 'should return the overview from the params with string keys' do
    company = CrunchbaseEntity.new('overview' => 'A social network')
    expect(company.overview).to eq('A social network')
  end
end