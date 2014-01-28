class SearchController < ApplicationController
  def index
    @results = AggregatedSearch.new.search(params[:query], page) if params[:query].present?
  end

  private
  def page
    params[:page] || '1'
  end
end