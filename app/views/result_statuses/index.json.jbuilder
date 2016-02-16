json.array!(@result_statuses) do |result_status|
  json.extract! result_status, :id, :name
  json.url result_status_url(result_status, format: :json)
end
