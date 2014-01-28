class CachedHttpClient
  def self.get url, params
    #TODO: Cached to external store
    #TODO: Respect cache headers and etags
    from_store(url, params) || from_url(url, params)
  end

  def self.reset!
    @@store = {}
  end

  private
  def self.make_key(url, params)
    url + params.to_query
  end

  def self.from_store url, params
    @@store ||= {}
    @@store[make_key(url, params)]
  end

  def self.from_url url, params
    content = RestClient.get(url, params.dup)
    Rails.logger.info "Cache miss:: #{make_key(url, params)}"
    @@store[make_key(url, params)] = content
    content
  end
end