class ConcertListsController < ApplicationController
  before_action :set_concert_list, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :only_user

  def index
    @concert_lists = ConcertList.all
  end

  def show
  end

  def new
    @concert_list = ConcertList.new
  end

  def edit
  end

  def create
    concert_list_params[:list_owner_id] = current_user.id
    @concert_list = ConcertList.new(concert_list_params)
    if @concert_list.save
      concerts = get_concerts(concert_ids_params)
      set_recommendations(@concert_list, concerts)
      redirect_to @concert_list, notice: 'Concert list was successfully created.'
    else
      render :new
    end
  end

  def update
    if @concert_list.update(concert_list_params)
      concerts = get_concerts(concert_ids_params)
      @concert_list.reset_recommendations
      set_recommendations(@concert_list, concerts)
      redirect_to @concert_list, notice: 'Concert list was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @concert_list.destroy
    redirect_to concert_lists_url, notice: 'Concert list was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concert_list
      @concert_list = ConcertList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concert_list_params
      params.require(:concert_list).permit(:list_owner_id, :title, :description)
    end

    def concert_ids_params
      params.require(:concert_list).permit(concert_ids: [])
    end

    def get_concerts(concert_ids)
      concerts = Array.new
      concert_ids[:concert_ids].each do |concert_id|
        p concert_id
        p concerts << Concert.find(concert_id.to_i) unless concert_id == ""
      end
      concerts
    end

    def set_recommendations(concert_list, concerts)
      concerts.each do |concert|
        concert_list.set_recommendation(concert)
      end
    end

    # Confirms the correct user.
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to user_login_url
      end
    end

    def only_user
      redirect_to root_url if user_or_band == "Band"
    end
end
