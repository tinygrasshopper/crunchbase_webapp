class Company < CrunchbaseEntity
  def people
    @params[:relationships].collect { |hash| Person.new(hash) }
  end
end