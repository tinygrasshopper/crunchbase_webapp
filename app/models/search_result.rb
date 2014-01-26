class SearchResult
  def initialize params
    @params = params.with_indifferent_access
  end

  def == other
    self.page == other.page && self.results == other.results
  end

  def page
    @params[:page]
  end

  def results
    @params[:results]
  end


end