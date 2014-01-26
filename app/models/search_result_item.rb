class SearchResultItem
  def initialize params
    @params = params.with_indifferent_access
  end

  def name
    @params[:name]
  end

  def description
    @params[:description]
  end

  def namespace
    @params[:namespace]
  end

  def == other
    other.class == self.class &&
        other.name == self.name &&
        other.description ==self.description &&
        other.namespace == self.namespace
  end

  def company?
    namespace == 'company'
  end

  def product?
    namespace == 'product'
  end

  def image
    @params[:image][:available_sizes].first.last unless @params[:image].nil?
  end
end