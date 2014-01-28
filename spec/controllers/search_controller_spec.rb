require 'spec_helper'
describe SearchController do
  it 'should delegate search to the CrunchBaseClient' do
    result = double(AggregatedSearchResult)
    expect_any_instance_of(AggregatedSearch).to receive(:search).
                                                    with('test', '3').
                                                    and_return(result)

    get :index, query: 'test', page: 3

    expect(assigns(:results)).to eq(result)
  end

  it 'should use the default page of 1' do
    result = double(AggregatedSearchResult)
    expect_any_instance_of(AggregatedSearch).to receive(:search).
                                                    with('test', '1').
                                                    and_return(result)

    get :index, query: 'test'

    expect(assigns(:results)).to eq(result)
  end

  it 'should not search if no query given' do
    expect_any_instance_of(AggregatedSearch).not_to receive(:search)

    get :index, query: ''
  end

  it 'should render the index view' do
    expect_any_instance_of(AggregatedSearch).to receive(:search).and_return({results: []})

    get :index, query: 'test'

    expect(response).to be_successful
    expect(response).to render_template('index')
  end
end