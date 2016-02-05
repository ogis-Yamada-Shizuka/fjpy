json.array!(@system_models) do |system_model|
  json.extract! system_model, :id, :name, :inspection_cycle_month
  json.url system_model_url(system_model, format: :json)
end
