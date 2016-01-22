json.array!(@infomsgs) do |infomsg|
  json.extract! infomsg, :id, :effective_date, :title, :description
  json.url infomsg_url(infomsg, format: :json)
end
