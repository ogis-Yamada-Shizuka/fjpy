json.array!(@inspection_results) do |inspection_result|
  json.extract! inspection_result, :id, :user_id, :latitude, :longitude
  json.url inspection_result_url(inspection_result, format: :json)
end
