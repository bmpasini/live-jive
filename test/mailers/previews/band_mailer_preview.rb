# Preview all emails at http://localhost:3000/rails/mailers/band_mailer
class BandMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/band_mailer/account_activation
  def account_activation
    band = Band.first
    band.activation_token = Band.new_token
    BandMailer.account_activation(band)
  end

  # Preview this email at
  # http://localhost:3000/rails/mailers/band_mailer/password_reset
  def password_reset
    band = Band.first
    band.reset_token = Band.new_token
    bandMailer.password_reset(band)
  end
end

end
