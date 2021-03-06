class FanshipsController < ApplicationController
	before_action :logged_in_user

  def create
    @band = Band.find(params[:band_id])
    current_user.become_fan(@band)
    respond_to do |format|
      format.html { redirect_to @band }
      format.js
    end
  end

  def destroy
    @band = Fanships.find(params[:id]).band
    current_user.undo_become_fan(@band)
    respond_to do |format|
      format.html { redirect_to @band }
      format.js
    end
  end

  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to user_login_url
      end
    end
end
