class Electorate < ActiveRecord::Base

  acts_as_url :name

  def bounding_box
    @bbox ||= RGeo::Cartesian::BoundingBox.create_from_geometry(area)
  end

  def to_param
    url
  end

end
