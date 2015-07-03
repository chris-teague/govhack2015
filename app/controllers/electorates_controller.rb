class ElectoratesController < ApplicationController

  def show
    @electorate = Electorate.find_by_url(params[:id])
  end

end
