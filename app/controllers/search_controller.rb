class SearchController < ApplicationController
  def locations
    postcodes = Postcode.select([:name, :id]).where('name ILIKE ?', "%#{params[:term]}%").limit(100).all
    electorates = Electorate.select([:name, :id]).where('name ILIKE ?', "%#{params[:term]}%").limit(100).all
    results = (postcodes | electorates).map { |t| { value: t.name, id: "#{t.class}:#{t.id}" } }
    render text: results.to_json
  end
end