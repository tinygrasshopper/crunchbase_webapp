require 'spec_helper'

describe SearchHelper do
  describe :crunchbase_image_url do
    it 'should return the crunchbase url for an item' do
      expect(crunchbase_image_url('google.img')).to eq('http://www.crunchbase.com/google.img')
    end
  end
end