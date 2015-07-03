class PostcodesController < ApplicationController

  def show
    @postcode = Postcode.find(params[:id])
  end

end
