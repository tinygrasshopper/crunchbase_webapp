class Milestone
  def initialize params
    @params = params.with_indifferent_access
  end
  def params
    @params
  end

  def == other
    self.class == other.class && self.params == other.params
  end

  def url
    @params[:source_url]
  end

  def description
    @params[:description]
  end

  def source_description
    @params[:source_description]
  end

  def date
    Date.new(@params[:stoned_year], @params[:stoned_month], @params[:stoned_day])
  end
end