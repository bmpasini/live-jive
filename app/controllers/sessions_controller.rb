class SessionsController < ApplicationController
  def user_login
  end

  def band_login
  end

  def user_create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'user_login'
    end
  end

  def band_create
    band = Band.find_by(bandname: params[:session][:bandname].downcase)
    if band && band.authenticate(params[:session][:password])
      log_in band
      remember band
      redirect_to band
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'band_login'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end