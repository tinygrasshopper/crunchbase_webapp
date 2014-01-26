class Company
  class << self
    def find id
      crunchbase_client = CrunchbaseClient.new
      Company.new(crunchbase_client.get('company', id))
    end
  end

  def initialize params
    @params = params
  end

  def params
    @params
  end


  def == other
    self.class ==other.class && self.params == other.params
  end
end