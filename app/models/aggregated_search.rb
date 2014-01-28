class AggregatedSearch
  def search term, page
    crunchbase_page_number = 1
    aggregated_page_number = 1
    has_more_pages = true

    products_overflow = []
    companies_overflow = []

    while aggregated_page_number <= page.to_i
      aggregated_result_page = AggregatedSearchResult.new(aggregated_page_number)
      products_overflow = aggregated_result_page.append_products!(products_overflow)
      companies_overflow = aggregated_result_page.append_companies!(companies_overflow)

      while has_more_pages and !aggregated_result_page.full?
        crunchbase_page = search_client.search(term, crunchbase_page_number)
        companies_overflow.concat(aggregated_result_page.append_companies!(crunchbase_page.companies))
        products_overflow.concat(aggregated_result_page.append_products!(crunchbase_page.products))

        crunchbase_page_number = crunchbase_page_number.next
        has_more_pages = !crunchbase_page.last?
      end

      aggregated_result_page.last = !has_more_pages && products_overflow.empty? && companies_overflow.empty?
      aggregated_page_number = aggregated_page_number.next
    end
    aggregated_result_page
  end

  def search_client
    @search ||= Search.new
  end
end