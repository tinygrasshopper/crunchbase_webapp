require 'spec_helper'
describe SearchController do
  it 'should delegate search to the CrunchBaseClient' do
    results = double(SearchResult)
    expect_any_instance_of(CrunchbaseClient).to receive(:search).
                                                    with('test').
                                                    and_return(results)

    get :index, query: 'test'

    expect(assigns(:results)).to eq(results)
  end

  it 'should not search if no query given' do
    expect_any_instance_of(CrunchbaseClient).not_to receive(:search)

    get :index, query: ''
  end

  it 'should delegate search to the CrunchBaseClient' do
    expect_any_instance_of(CrunchbaseClient).to receive(:search)

    get :index, query: 'test'

    expect(response).to be_successful
    expect(response).to render_template('index')
  end
end