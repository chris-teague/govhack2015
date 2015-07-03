class CreateElectorates < ActiveRecord::Migration
  def change
    create_table :electorates do |t|
      t.string :name
      t.multi_polygon :area, srid: 4326
      t.timestamps null: false
    end

    add_index :electorates, :area, using: :gist
  end
end
