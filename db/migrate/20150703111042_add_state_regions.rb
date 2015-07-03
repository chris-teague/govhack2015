class AddStateRegions < ActiveRecord::Migration
  def change
    create_table :postcodes do |t|
      t.string :name
      t.multi_polygon :area, srid: 4326
    end

    add_index :postcodes, :area, using: :gist
  end
end
