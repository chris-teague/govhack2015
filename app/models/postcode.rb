class Postcode < ActiveRecord::Base

  def bounding_box
    RGeo::Cartesian::BoundingBox.create_from_geometry(area)
  end

end