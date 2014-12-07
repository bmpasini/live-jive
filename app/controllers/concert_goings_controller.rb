class ConcertGoingsController < ApplicationController
  before_action :set_concert_going, only: [:update, :destroy]
	before_action :logged_in_user

	def create
    @concert = Concert.find(params[:concert_id])
    current_user.rsvp(@concert)
    respond_to do |format|
      format.html { redirect_to @concert }
      format.js
    end
  end

  def edit
  end

  def update
    if @concert_going.update_attributes(concert_going_params)
      flash[:success] = "Concert was successfully reviewed!" 
      redirect_to @concert_going.concert
    else
      render :edit
    end
  end

  def destroy
    @concert = @concert_going.concert
    current_user.cancel_rsvp(@concert)
    respond_to do |format|
      format.html { redirect_to @concert }
      format.js
    end
  end

  private
    def set_concert_going
      @concert_going = ConcertGoings.find(params[:id])
    end

    def concert_going_params
      params.require(:concert_goings).permit(:review, :rating)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to user_login_url
      end
    end
end
