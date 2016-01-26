json.array!(@equipment) do |equipment|
  json.extract! equipment, :id, :name, :system_model_id, :place_id
  json.url equipment_url(equipment, format: :json)
end
