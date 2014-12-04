json.array!(@bands) do |band|
  json.extract! band, :id, :bandname, :name, :description, :website, :email, :identity_confirmed?
  json.url band_url(band, format: :json)
end
