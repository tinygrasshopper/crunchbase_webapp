class Person
  def initialize params
    @params = params.with_indifferent_access
  end

  def params
    @params
  end

  def id
    @params[:person][:permalink]
  end

  def role
    @params[:title]
  end

  def first_name
    @params[:person][:first_name]
  end

  def last_name
    @params[:person][:last_name]
  end

  def == other
    self.class == other.class && self.params == other.params
  end
end