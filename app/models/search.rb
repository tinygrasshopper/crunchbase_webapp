class Search
  def search(term, page)
    SearchResult.new(CrunchbaseClient.new.search(term, page))
  end
end