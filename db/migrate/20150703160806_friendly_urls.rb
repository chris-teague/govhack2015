class FriendlyUrls < ActiveRecord::Migration
  def change
    add_column :postcodes,   :url, :string
    add_column :electorates, :url, :string
    add_index  :postcodes, :area, using: :gist
  end
end
