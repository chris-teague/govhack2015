require 'rgeo/shapefile'
require 'set'

factory = RGeo::Geographic.spherical_factory(srid: 4326)
file = "#{Rails.root}/lib/data/zones/dd_z_statewide_shp.shp"

RGeo::Shapefile::Reader.open(file, factory: factory) do |file|

  data_set = DataSet.create(name: "SA Land Zone Information")

  puts "File contains #{file.num_records} records."

  file.each do |record|
    d = DataEntity.new
    d.data = record.attributes
    d.area = record.geometry
    d.data_set_id = data_set.id
    d.save!
  end

end
