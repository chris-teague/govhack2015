class DataEntity < ActiveRecord::Base

  attr_accessor :st_asgeojson, :st_area

  belongs_to :data_set

end
