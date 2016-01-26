json.array!(@inspection_schedules) do |inspection_schedule|
  json.extract! inspection_schedule, :id, :targetyearmonth, :references, :references, :references, :references, :processingdate
  json.url inspection_schedule_url(inspection_schedule, format: :json)
end
