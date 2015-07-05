class DataSetIndexer < ActiveRecord::Migration
  def change
    # CREATE INDEX sa_digit_index ON data_entities USING gin (SA1_7DIGIT);
  end
end
