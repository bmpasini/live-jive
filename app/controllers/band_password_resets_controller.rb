class BandPasswordResetsController < ApplicationController
	before_action :get_band, only: [:edit, :update]
  before_action :valid_band, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @band = Band.find_by(email: params[:band_password_reset][:email].downcase)
    if @band
      @band.create_reset_digest
      @band.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to band_login_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if both_passwords_blank?
      flash.now[:danger] = "Password/confirmation can't be blank"
      render 'edit'
    elsif @band.update_attributes(band_params)
      log_in @band
      flash[:success] = "Your password has been successfully reset."
      redirect_to @band
    else
      render 'edit'
    end
  end

  private

  	def band_params
      params.require(:band).permit(:password, :password_confirmation)
    end

    # Returns true if password & confirmation are blank.
    def both_passwords_blank?
      params[:band][:password].blank? && params[:band][:password_confirmation].blank?
    end

    def get_band
      @band = Band.find_by(email: params[:email])
    end

    # Confirms a valid band.
    def valid_band
      unless (@band && @band.identity_confirmed? && @band.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # Checks expiration of reset token.
    def check_expiration
      if @band.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end
