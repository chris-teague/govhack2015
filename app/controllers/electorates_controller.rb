class ElectoratesController < ApplicationController

  def show
    @electorate = Electorate.find_by_url(params[:id])
  end

  def compare
    @electorate = Electorate.find_by_url(params[:id])
    @comparison = Electorate.find_by_url(params[:comparison_id])
  end

end
