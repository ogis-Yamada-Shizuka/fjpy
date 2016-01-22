json.array!(@flags) do |flag|
  json.extract! flag, :id, :name
  json.url flag_url(flag, format: :json)
end
