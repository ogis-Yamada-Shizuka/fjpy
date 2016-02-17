json.array!(@schedule_statuses) do |schedule_status|
  json.extract! schedule_status, :id, :name
  json.url schedule_status_url(schedule_status, format: :json)
end
