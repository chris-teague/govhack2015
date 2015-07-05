class Electorate < ActiveRecord::Base

  acts_as_url :name

  def bounding_box
    @bbox ||= RGeo::Cartesian::BoundingBox.create_from_geometry(area)
  end

  def to_param
    url
  end

  def meters_squared
    self.class.connection.execute(
      "SELECT st_area(e.area)
       FROM   electorates e
       WHERE  e.id = #{id}").first["st_area"]
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

  def contained_data_sets
    DataSet.find_by_sql(
      "SELECT d.id, d.name, d.area
       FROM   data_sets d
       WHERE  d.area IS NOT NULL AND
              ST_Intersects((SELECT area FROM electorates WHERE id = #{id}), d.area)")
  end

end
