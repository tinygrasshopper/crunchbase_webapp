class AggregatedSearch
  def search term, page
    base_page = 1
    aggregated_result = AggregatedSearchResult.new(page)

    begin
      search_result = search_client.search(term, base_page)
      aggregated_result.append_companies! search_result.companies
      aggregated_result.append_products! search_result.products
      base_page = base_page.next
    end while !(search_result.last? or (aggregated_result.full?))

    aggregated_result
  end

  def search_client
    @search ||= Search.new
  end
end