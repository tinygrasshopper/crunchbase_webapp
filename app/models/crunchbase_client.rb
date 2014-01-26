class CrunchbaseClient
  def search query
    response = JSON.parse(RestClient.get('http://api.crunchbase.com/v/1/search.js', params: {query: query, api_key: 'vnqmjpk7xb3cx5tqyh4s5j64'}))
    SearchResult.new(response)
  end

  def get type, permalink
    JSON.parse(RestClient.get("http://api.crunchbase.com/v/1/#{type}/#{permalink}.js", params: {api_key: 'vnqmjpk7xb3cx5tqyh4s5j64'}))
  end
end