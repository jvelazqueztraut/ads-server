json.array!(@users) do |user|
  json.extract! user, :id, :email, :token
  json.url user_url(user, format: :json)
end
