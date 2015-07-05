class AddSomeIndexes < ActiveRecord::Migration
  def change
    add_index :data_entities, :area, using: :gist
    add_index :data_sets, :bounds, using: :gist
  end
end
