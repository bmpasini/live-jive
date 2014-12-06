class AccountActivationsController < ApplicationController

	def edit
    band = Band.find_by(email: params[:email])
    if band && !band.activated? && band.authenticated?(:activation, params[:id])
    	band.activate
      log_in band
      flash[:success] = "Identity confirmed!"
      redirect_to band
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
