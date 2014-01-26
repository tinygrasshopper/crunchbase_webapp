class SearchController < ApplicationController
  def index
    crunchbase_client = CrunchbaseClient.new
    @results = crunchbase_client.search(params[:query]) if params[:query].present?
  end
end