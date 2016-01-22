require 'csv'

csv_data = CSV.generate( "", {:row_sep => "\r\n", :force_quotes => true} ) do |csv|
  csv << @workers.column_names
  @workers.each do |model|
    csv << model.attributes.values_at(*@workers.column_names)
  end
end

csv_data.encode(Encoding::SJIS,:undef => :replace, :invalid => :replace)

