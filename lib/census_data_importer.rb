file = "#{Rails.root}/lib/data/census/2011Census_B02_AUST_SA1_short.csv"

csv = CSV.new(File.read(file))

names = []

csv.each_with_index do |row, index|

  if index == 0
    names = row[1..-1]
  else
    data = {}
    d = DataEntity.select(:id, :data).where("data_set_id = 3 AND data ->> 'SA1_7DIGIT' = '#{row[0]}'").first

    if d
      row[1..-1].each_with_index do |row_data, i|
        data[names[i]] = row_data
      end
    end
    d.data.merge(data)
    d.save!
  end
end
