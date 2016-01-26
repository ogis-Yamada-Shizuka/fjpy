json.array!(@inspection_periods) do |inspection_period|
  json.extract! inspection_period, :id
  json.url inspection_period_url(inspection_period, format: :json)
end
