json.array!(@kirokus) do |kiroku|
  json.extract! kiroku, :id, :user_id, :latitude, :longitude
  json.url kiroku_url(kiroku, format: :json)
end
