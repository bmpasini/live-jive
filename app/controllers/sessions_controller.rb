class SessionsController < ApplicationController
  before_action :if_logged_in, only: [:user_login, :band_login]

  def user_login
  end

  def band_login
  end

  def user_create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'user_login'
    end
  end

  def band_create
    band = Band.find_by(bandname: params[:session][:bandname].downcase)
    if band && band.authenticate(params[:session][:password])
      if band.identity_confirmed?
        log_in band
        params[:session][:remember_me] == '1' ? remember(band) : forget(band)
        redirect_back_or band
      else
        message  = "Your identity has not been confirmed yet. "
        message += "Please check your email."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'band_login'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
    def if_logged_in
      redirect_to root_url if logged_in?
    end
end