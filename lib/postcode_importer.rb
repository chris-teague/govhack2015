require 'rgeo/shapefile'

factory = RGeo::Geographic.spherical_factory(srid: 4326)
file = "#{Rails.root}/lib/data/postcodes/simplified.shp"

RGeo::Shapefile::Reader.open(file, factory: factory) do |file|
  puts "File contains #{file.num_records} records."
  file.each do |record|
    p = Postcode.new
    p.name = record.attributes["NAME_2006"]
    p.area = record.geometry
    p.state_id = record.attributes["STATE_2006"].to_i
    p.save!
  end
end
