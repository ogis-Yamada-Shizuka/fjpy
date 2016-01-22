json.array!(@weathers) do |weather|
  json.extract! weather, :id, :name
  json.url weather_url(weather, format: :json)
end
