json.array!(@concerts) do |concert|
  json.extract! concert, :id, :cdate, :ctime, :location_name, :ccity, :buy_tickets_website
  json.url concert_url(concert, format: :json)
end
