class Product <CrunchbaseEntity

  def milestones
    @params[:milestones].collect { |hash| Milestone.new(hash) }
  end

end