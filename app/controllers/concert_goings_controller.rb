class ConcertGoingsController < ApplicationController
	before_action :logged_in_user

	def create
    @concert = Concert.find(params[:concert_id])
    current_user.rsvp(@concert)
    respond_to do |format|
      format.html { redirect_to @concert }
      format.js
    end
  end

  def destroy
    @concert = ConcertGoings.find(params[:id]).concert
    current_user.cancel_rsvp(@concert)
    respond_to do |format|
      format.html { redirect_to @concert }
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
