json.array!(@companies) do |company|
  json.extract! company, :id, :code, :name, :type
  json.url company_url(company, format: :json)
end
