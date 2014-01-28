require 'spec_helper'
describe SearchController do
  it 'should delegate search to the CrunchBaseClient' do
    result_json = {page: 1, results: []}
    expect_any_instance_of(CrunchbaseClient).to receive(:search).
                                                    with('test', '3').
                                                    and_return(result_json)

    get :index, query: 'test', page: 3

    expect(assigns(:results)).to eq(SearchResult.new(result_json))
  end

  it 'should use the default page of 1' do
    result_json = {page: 1, results: []}
    expect_any_instance_of(CrunchbaseClient).to receive(:search).
                                                    with('test', '1').
                                                    and_return(result_json)

    get :index, query: 'test'

    expect(assigns(:results)).to eq(SearchResult.new(result_json))
  end

  it 'should not search if no query given' do
    expect_any_instance_of(CrunchbaseClient).not_to receive(:search)

    get :index, query: ''
  end

  it 'should render the index view' do
    expect_any_instance_of(CrunchbaseClient).to receive(:search).and_return({results: []})

    get :index, query: 'test'

    expect(response).to be_successful
    expect(response).to render_template('index')
  end
end