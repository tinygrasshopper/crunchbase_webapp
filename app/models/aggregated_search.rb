class AggregatedSearch
  def search term, page
    crunchbase_page_number = 1
    aggregated_page = 1

    has_more_pages = true

    products_overflow = []
    companies_overflow = []

    while aggregated_page <= page.to_i
      aggregated_result = AggregatedSearchResult.new(aggregated_page)
      products_overflow = aggregated_result.append_products!(products_overflow) if products_overflow.present?
      companies_overflow = aggregated_result.append_companies!(companies_overflow) if companies_overflow.present?

      while has_more_pages and !aggregated_result.full?
        crunchbase_page = search_client.search(term, crunchbase_page_number)
        companies_overflow.concat(aggregated_result.append_companies!(crunchbase_page.companies))
        products_overflow.concat(aggregated_result.append_products!(crunchbase_page.products))

        crunchbase_page_number = crunchbase_page_number.next
        has_more_pages = !crunchbase_page.last?
      end

      aggregated_result.last = !has_more_pages && products_overflow.empty? && companies_overflow.empty?
      aggregated_page = aggregated_page.next
    end
    aggregated_result
  end

  def search_client
    @search ||= Search.new
  end
end