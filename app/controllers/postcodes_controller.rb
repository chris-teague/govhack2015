class PostcodesController < ApplicationController

  def show
    @postcode = Postcode.find_by_url(params[:id])
  end

end
