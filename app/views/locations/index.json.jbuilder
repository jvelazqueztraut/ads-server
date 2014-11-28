json.array!(@locations) do |location|
  json.extract! location, :id, :latitude, :longitude, :date, :tablet_id
  json.url location_url(location, format: :json)
end
