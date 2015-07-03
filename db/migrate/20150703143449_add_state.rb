class AddState < ActiveRecord::Migration
  def change
    remove_index :postcodes, :area

    add_column :postcodes, :state_id, :integer

    create_table "states", force: :cascade do |t|
      t.string   "name"
    end
  end
end
