json.array!(@users) do |user|
  json.extract! user, :id, :username, :name, :year_of_birth, :email, :password, :city_of_birth, :reputation_score, :is_admin?, :last_login_at, :current_login_at
  json.url user_url(user, format: :json)
end
