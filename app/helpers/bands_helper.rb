module BandsHelper
	# Returns the Gravatar for the given band.
  def gravatar_for(band)
    gravatar_id = Digest::MD5::hexdigest(band.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: band.name, class: "gravatar")
  end
end
