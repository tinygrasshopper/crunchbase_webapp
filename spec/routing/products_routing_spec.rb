require 'spec_helper'
describe 'Products Routing' do
  it 'should route /products/:id to search controller' do
    {:get => '/products/test'}.should route_to(:controller => 'products', :action => 'show', id: 'test')
  end

end