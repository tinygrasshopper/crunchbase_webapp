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
end