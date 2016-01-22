json.array!(@topics) do |topic|
  json.extract! topic, :id, :title, :name, :description, :flag_id
  json.url topic_url(topic, format: :json)
end
