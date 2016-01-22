json.array!(@inspections) do |inspection|
  json.extract! inspection, :id, :targetyearmonth, :references, :references, :references, :references, :processingdate
  json.url inspection_url(inspection, format: :json)
end
