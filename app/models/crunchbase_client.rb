class CrunchbaseClient
  def search query, page
    response = JSON.parse(RestClient.get('http://api.crunchbase.com/v/1/search.js', params: {query: query, api_key: 'vnqmjpk7xb3cx5tqyh4s5j64', page: page}))
    #TODO: Make api consistent
    SearchResult.new(response)
  end

  def get type, permalink
    #TODO: Remove duplication of key
    #TODO: Add key to config
    JSON.parse(RestClient.get("http://api.crunchbase.com/v/1/#{type}/#{permalink}.js", params: {api_key: 'vnqmjpk7xb3cx5tqyh4s5j64'}))
  end
end