require 'spec_helper'

describe Search do
  subject { Search.new }
  it 'uses the Crunchbase Api to search' do
    result_json = {page: 1, results: []}
    expect_any_instance_of(CrunchbaseClient).to receive(:search).
                                                    with('test', '3').
                                                    and_return(result_json)

    expect(subject.search('test', '3')).to eq(SearchResult.new(result_json))

  end
end