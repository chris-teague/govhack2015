class DataToEletorates < ActiveRecord::Migration
  def change
    add_column :electorates, :data, :json
  end
end
