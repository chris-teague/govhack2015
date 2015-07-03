class SearchController < ApplicationController
  def locations
    postcodes = Postcode.select([:name, :id]).where('name ILIKE ?', "%#{params[:term]}%").limit(100).all
    electorates = Electorate.select([:name, :id]).where('name ILIKE ?', "%#{params[:term]}%").limit(100).all
    results = (postcodes | electorates).map { |t| { value: t.name, id: "#{t.class}:#{t.id}" } }
    render text: results.to_json
  end

  def relocate
    if postcode = Postcode.where(name: params[:location]).first
      redirect_to postcode_url(postcode.id)
    elsif electorate = Electorate.where(name: params[:location]).first
      redirect_to electorate_url(electorate.id)
    else
      flash[:notice] = "Can't find your location, yo"
      redirect_to '/'
    end
  end
end