json.array!(@concert_lists) do |concert_list|
  json.extract! concert_list, :id, :list_owner_id, :title, :description
  json.url concert_list_url(concert_list, format: :json)
end
