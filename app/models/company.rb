class Company
  class << self
    def find id
      crunchbase_client = CrunchbaseClient.new
      Company.new(crunchbase_client.get('company', id))
    end
  end

  def initialize params
    @params = params.with_indifferent_access
  end

  def params
    @params
  end

  def overview
    @params[:overview]
  end

  def people
    @params[:relationships].collect { |hash| Person.new(hash) }
  end

  def image
    @params[:image][:available_sizes].last.last unless @params[:image].nil?
  end

  def name
    @params[:name]
  end

  def url
    @params[:crunchbase_url]
  end

  def == other
    self.class ==other.class && self.params == other.params
  end
end