json.array!(@checkresults) do |checkresult|
  json.extract! checkresult, :id, :name
  json.url checkresult_url(checkresult, format: :json)
end
