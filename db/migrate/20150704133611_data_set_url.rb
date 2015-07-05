class DataSetUrl < ActiveRecord::Migration
  def change
    add_column :data_sets, :url, :string
  end
end
