class SearchResult
  attr_reader :results

  def initialize params
    @params = params.with_indifferent_access
    @results = @params[:results].collect { |hash| SearchResultItem.new(hash) }
  end

  def == other
    self.page == other.page && self.results == other.results
  end

  def page
    @params[:page]
  end

  def companies
    results.select(&:company?)
  end

  def products
    results.select(&:product?)
  end
end