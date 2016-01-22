json.array!(@checks) do |check|
  json.extract! check, :id, :weather_id, :exterior, :tone, :stain
  json.url check_url(check, format: :json)
end
