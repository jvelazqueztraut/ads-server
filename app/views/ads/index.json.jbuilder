json.array!(@ads) do |ad|
  json.extract! ad, :id, :picture_url, :destination_url, :description
  json.url ad_url(ad, format: :json)
end
