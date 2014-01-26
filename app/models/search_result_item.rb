class SearchResultItem
  attr_reader :name, :description, :namespace

  def initialize params
    params = params.with_indifferent_access
    @name = params[:name]
    @description = params[:description]
    @namespace = params[:namespace]
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
end