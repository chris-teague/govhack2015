class Electorate < ActiveRecord::Base

  acts_as_url :name

  def bounding_box
    @bbox ||= RGeo::Cartesian::BoundingBox.create_from_geometry(area)
  end

  def to_param
    url
  end

  def neigbouring
    Electorate.find_by_sql(
      "SELECT e.*
       FROM   electorates e
       WHERE  e.id != #{id} AND
              ST_Intersects(ST_Expand((SELECT area FROM electorates WHERE id = #{id}), 0.02), e.area)")
  end

  def neigbouring_postcodes
    Postcode.find_by_sql(
      "SELECT p.*
       FROM   postcodes p
       WHERE  ST_Intersects(ST_Expand((SELECT area FROM electorates WHERE id = #{id}), 0.02), p.area)")
  end

end
