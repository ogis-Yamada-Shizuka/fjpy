json.array!(@notes) do |note|
  json.extract! note, :id, :memo, :picture
  json.url note_url(note, format: :json)
end
