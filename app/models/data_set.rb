class DataSet < ActiveRecord::Base

  has_many :data_entities

  acts_as_url :name

  #
  # Use this to have a simple bounding box esque check to see whether the underlying
  # data entities are actually relevant to the current area being looked at.
  #
  def update_bounds
    query = <<-SQL
      UPDATE data_sets
      SET area = (
                  SELECT ST_Multi(ST_ConvexHull(ST_Collect(area)))
                  FROM data_entities
                  WHERE data_set_id = #{id}
                  )
      WHERE id = #{id};
    SQL

    self.class.connection.execute(query)
  end

  def contained_data_entities(electorate)
    DataEntity.find_by_sql(
      "SELECT d.id, d.data, d.area
       FROM   data_entities d
       WHERE  d.data_set_id = #{id} AND
              ST_Within((SELECT area FROM electorates WHERE id = #{electorate.id}), d.area)")
  end

  def contained_data_entity_areas(electorate)
    DataEntity.find_by_sql(
      "SELECT ST_asgeojson(ST_Multi(d.area)), ST_area(ST_Intersection(d.area, e.area)), d.data
       FROM   data_entities d, electorates e
       WHERE  d.data_set_id = #{id} AND
              ST_Intersects((SELECT area FROM electorates WHERE id = #{electorate.id}), d.area)
              AND e.id = #{electorate.id}")
  end

end
