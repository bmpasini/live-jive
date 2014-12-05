module BandsHelper
  # Returns the Gravatar for the given band.
  def gravatar_for(band, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(band.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: band.name, class: "gravatar")
  end
end