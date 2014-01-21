require 'spec_helper'
describe 'Search Routing' do
  it 'should route / to search controller' do
    {:get => '/'}.should route_to(:controller => 'search', :action => 'index')
  end

  it 'should route root to search controller' do
    {:get => root_path}.should route_to(:controller => 'search', :action => 'index')
  end
end