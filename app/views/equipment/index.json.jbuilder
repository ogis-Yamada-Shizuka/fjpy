json.array!(@equipment) do |equipment|
  json.extract! equipment, :id, :serial_number, :system_model_id, :place_id
  json.url equipment_url(equipment, format: :json)
end
