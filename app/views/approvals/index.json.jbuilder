json.array!(@approvals) do |approval|
  json.extract! approval, :id, :inspection_schedule_id, :signature
  json.url approval_url(approval, format: :json)
end
