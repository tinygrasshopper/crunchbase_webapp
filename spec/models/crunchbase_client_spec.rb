describe CrunchbaseClient do
  subject { CrunchbaseClient.new }
  describe :search do
    it 'should search using the api client, using the params' do
      json_response = '{"total": 1,
        "page": 1,
        "crunchbase_url": "http://www.crunchbase.com/search?query=mock",
        "results": [
        {
            "first_name": "Facebook",
            "last_name": "Andrew",
            "permalink": "mike-andrew",
            "crunchbase_url": "http://www.crunchbase.com/person/mike-andrew",
            "homepage_url": "",
            "namespace": "person",
            "overview": "Formerly Mike Anderson.",
            "image": null
        }
    ]}'
      expect(RestClient).to receive(:get)
                            .with('http://api.crunchbase.com/v/1/search.js', params: {query: 'test', api_key: 'vnqmjpk7xb3cx5tqyh4s5j64', page: '2'})
                            .and_return(json_response)

      results = subject.search 'test', '2'

      expect(results).to eq(SearchResult.new(JSON.parse(json_response)))
    end
  end

  describe :get do
    it 'should fetch using the entity api' do
      json_response = '{"name": "facebook",
                        "permalink": "facebook"}'

      expect(RestClient).to receive(:get)
                            .with('http://api.crunchbase.com/v/1/company/facebook.js', params: {api_key: 'vnqmjpk7xb3cx5tqyh4s5j64'})
                            .and_return(json_response)

      entity = subject.get 'company', 'facebook'

      expect(entity).to eq(JSON.parse(json_response))


    end
  end
end

