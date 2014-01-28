require 'spec_helper'
describe 'Companies Routing' do
  it 'should route /companies/:id to search controller' do
    {:get => '/companies/test'}.should route_to(:controller => 'companies', :action => 'show', id: 'test')
  end

end