json.array!(@tablets) do |tablet|
  json.extract! tablet, :id, :uuid, :flash_token, :salt, :flash_date, :user_id
  json.url tablet_url(tablet, format: :json)
end
