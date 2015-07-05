class CreateDataSets < ActiveRecord::Migration
  def change
    create_table :data_sets do |t|
      t.string :name
      t.multi_line_string :bounds, srid: 4326
      t.string :concrete_class, default: 'StraightOutput'
      t.jsonb :data
      t.timestamps null: false
    end

    create_table :data_entities do |t|
      t.integer :data_set_id, null: false
      t.multi_polygon :area, srid: 4326
      t.jsonb :data
      t.timestamps null: false
    end

    add_index :data_entities, :data_set_id
  end
end
