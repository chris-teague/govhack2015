class Postcode < ActiveRecord::Base

  acts_as_url :name

  def bounding_box
    @bbox ||= RGeo::Cartesian::BoundingBox.create_from_geometry(area)
  end

  def to_param
    url
  end

  def neigbouring
    Postcode.find_by_sql(
      "SELECT p.*
       FROM   postcodes p
       WHERE  p.id != #{id} AND
              ST_Contains(ST_Expand((SELECT area FROM postcodes WHERE id = #{id}), 0.02), p.area)")
  end

  def neigbouring_electorates
    Electorate.find_by_sql(
      "SELECT e.*
       FROM   electorates e
       WHERE  ST_Intersects(ST_Expand((SELECT area FROM postcodes WHERE id = #{id}), 0.02), e.area)")
  end

end
