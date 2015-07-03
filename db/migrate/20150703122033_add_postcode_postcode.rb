class AddPostcodePostcode < ActiveRecord::Migration
  def change
    add_column :postcodes, :postcode, :string
  end
end
