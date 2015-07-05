class DataSetArea < ActiveRecord::Migration
  def change
    add_column :data_sets, :area, :multi_polygon, srid: 4326
  end
end
