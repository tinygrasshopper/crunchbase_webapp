class AggregatedSearchResult
  attr_accessor :last
  alias :last? :last

  def initialize page
    @page = page
    @companies = []
    @products = []
  end

  def first?
    @page.to_i == 1
  end

  def companies
    @companies
  end

  def products
    @products
  end

  def append_companies! results
    @companies.concat(results[0...remaining_companies])
  end

  def append_products! results
    @products.concat(results[0...remaining_products])
  end

  def full?
    remaining_companies.zero? and remaining_products.zero?
  end

  def page
    @page.to_i
  end

  private
  def remaining_companies
    page_limit - @companies.count
  end

  def remaining_products
    page_limit - @products.count
  end

  def page_limit
    APP_CONFIG['aggregator_per_page']
  end
end