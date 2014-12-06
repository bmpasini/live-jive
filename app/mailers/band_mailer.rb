class BandMailer < ActionMailer::Base
  default from: "no-reply@livejive.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.band_mailer.account_activation.subject
  #
  def account_activation(band)
    @band = band
    mail to: band.email, subject: "LiveJive: Identity Confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.band_mailer.password_reset.subject
  #
  def password_reset(band)
    @band = band
    mail to: band.email, subject: "LiveJive - Password Reset"
  end
end
