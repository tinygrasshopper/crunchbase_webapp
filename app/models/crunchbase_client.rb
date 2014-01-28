class CrunchbaseClient
  def search query, page
    JSON.parse(http_get(search_url, {query: query, page: page}))
  end

  def get type, permalink
    JSON.parse(http_get(entity_url(permalink, type)))
  end

  private
  def http_get(url, params={})
    CachedHttpClient.get(url, params: {api_key: APP_CONFIG['crunchbase_key']}.merge(params))
  end

  def entity_url(permalink, type)
    "#{base_url}/#{type}/#{permalink}.js"
  end

  def search_url
    "#{base_url}/search.js"
  end

  def base_url
    'http://api.crunchbase.com/v/1'
  end
end