json.array!(@equipment) do |equipment|
  json.extract! equipment, :id, :name, :type_id, :place_id
  json.url equipment_url(equipment, format: :json)
end
