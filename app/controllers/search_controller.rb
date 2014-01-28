class SearchController < ApplicationController
  def index
    crunchbase_client = CrunchbaseClient.new
    @results = crunchbase_client.search(params[:query], page) if params[:query].present?
  end

  private
  def page
    params[:page] || '1'
  end
end