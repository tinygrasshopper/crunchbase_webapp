require 'spec_helper'

describe CachedHttpClient do
  it 'should use the rest client to make the request' do
    json_response= '{"test" => true}'
    expect(RestClient).to receive(:get)
                          .with('http://api.crunchbase.com/v/1/search.js', params: {query: 'test'})
                          .and_return(json_response)

    actual_response = CachedHttpClient.get('http://api.crunchbase.com/v/1/search.js', params: {query: 'test'})

    expect(actual_response).to eq(json_response)
  end

  it 'should cache the response' do
    json_response= '{"test" => true}'
    expect(RestClient).to receive(:get)
                          .with('http://api.crunchbase.com/v/1/search.js', params: {query: 'test'})
                          .and_return(json_response)
                          .once

    CachedHttpClient.get('http://api.crunchbase.com/v/1/search.js', params: {query: 'test'})
    actual_response = CachedHttpClient.get('http://api.crunchbase.com/v/1/search.js', params: {query: 'test'})

    expect(actual_response).to eq(json_response)
  end

  it 'should reset the cache' do

    json_response= '{"test" => true}'
    expect(RestClient).to receive(:get)
                          .with('http://api.crunchbase.com/v/1/search.js', params: {query: 'test'})
                          .and_return(json_response)
                          .twice

    CachedHttpClient.get('http://api.crunchbase.com/v/1/search.js', params: {query: 'test'})
    CachedHttpClient.reset!
    CachedHttpClient.get('http://api.crunchbase.com/v/1/search.js', params: {query: 'test'})

  end


end