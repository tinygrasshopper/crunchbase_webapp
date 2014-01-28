require 'spec_helper'

describe ProductsController do
  it 'should fetch the product information using the client' do
    product = double(Product)
    expect(Product).to receive(:find).
                           with('test').
                           and_return(product)

    get :show, id: 'test'

    expect(assigns(:product)).to eq(product)
  end
end