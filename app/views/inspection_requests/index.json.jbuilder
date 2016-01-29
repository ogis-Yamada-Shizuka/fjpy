json.array!(@inspection_requests) do |inspection_request|
  json.extract! inspection_request, :id, :service_id, :inspect_schedule_id, :schedule
  json.url inspection_request_url(inspection_request, format: :json)
end
