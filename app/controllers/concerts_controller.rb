class ConcertsController < ApplicationController
  before_action :set_concert, only: [:show, :edit, :update, :destroy]
  before_action :logged_in, only: [:index, :show, :edit, :update, :destroy]
  before_action :trusted_user, only: [:edit, :update]
  before_action :correct_band, only: [:edit, :update, :destroy]
  before_action :admin_user, only: :destroy

  def index
    @concerts = Concert.paginate(page: params[:page])
  end

  def show
    @concert_going = ConcertGoings.find_by(concert_id: @concert.id, goer_id: current_user.id) if user_or_band == "User"
  end

  def new
    @concert = Concert.new
  end

  def edit

  end

  def create
    @concert = Concert.new(concert_params)

    if @concert.save
      bands = get_bands(band_ids_params)
      set_lineups(@concert, bands)
      set_tickets(@concert)
      redirect_to @concert
      flash[:success] = 'Concert was successfully created.'
    else
      render :new
    end
  end

  def update
    if @concert.update(concert_params)
      erase_lineups(@concert)
      bands = get_bands(band_ids_params)
      set_lineups(@concert, bands)
      redirect_to @concert
      flash[:success] = 'Concert was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @concert.destroy
    redirect_to concerts_url
    flash[:success] = 'Concert was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concert
      @concert = Concert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concert_params
      params.require(:concert).permit(:title, :description, :cdatetime, :location_name, :ccity, :buy_tickets_website)
    end

    def band_ids_params
      params.require(:concert).permit(band_ids: [])
    end

    def tickets_params
      params.require(:concert).permit(:vip_tickets_how_many_left, :vip_tickets_price, :confort_how_many_left, :confort_price, :pavillion_tickets_how_many_left, :pavillion_tickets_price, :front_row_tickets_how_many_left, :front_row_tickets_price, :lounge_tickets_how_many_left, :lounge_tickets_price)
    end

    def get_tickets
      vip = Hash.new
      confort = Hash.new
      pavillion = Hash.new
      front_row = Hash.new
      lounge = Hash.new
      vip[:tier] = "VIP"
      vip[:how_many_left] = tickets_params[:vip_tickets_how_many_left]
      vip[:price] = tickets_params[:vip_tickets_price]
      confort[:tier] = "Confort"
      confort[:how_many_left] = tickets_params[:confort_how_many_left]
      confort[:price] = tickets_params[:confort_price]
      pavillion[:tier] = "Pavillion"
      pavillion[:how_many_left] = tickets_params[:pavillion_tickets_how_many_left]
      pavillion[:price] = tickets_params[:pavillion_tickets_price]
      front_row[:tier] = "Front Row"
      front_row[:how_many_left] = tickets_params[:front_row_tickets_how_many_left]
      front_row[:price] = tickets_params[:front_row_tickets_price]
      lounge[:tier] = "Lounge"
      lounge[:how_many_left] = tickets_params[:lounge_tickets_how_many_left]
      lounge[:price] = tickets_params[:lounge_tickets_price]
      [vip, confort, pavillion, front_row, lounge]
    end

    def set_tickets(concert)
      get_tickets.each do |ticket|
        concert.set_ticket(ticket)
      end
    end

    def get_bands(band_ids)
      bands = Array.new
      band_ids[:band_ids].each do |band_id|
        p band_id
        p bands << Band.find(band_id.to_i) unless band_id == ""
      end
      bands
    end

    def set_lineups(concert, bands)
      bands.each do |band|
        concert.set_lineup(band)
      end
    end

    def erase_lineups(concert)
      concert.lineups.each do |lineup|
        lineup.destroy
      end
    end

    # Confirms a logged-in.
    def logged_in
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to band_login_url
      end
    end

    # Confirms the correct band.
    def correct_band
      if user_or_band == "Band"
        redirect_to(root_url) unless @concert.band_in_concert?(current_band)
      else
        admin_user
      end
    end

    # Confirms an admin user.
    def admin_user
      if user_or_band == "User"
        redirect_to(root_url) unless current_user.is_admin?
      end
    end

    def trusted_user
      if user_or_band == "User"
        redirect_to(root_url) unless current_user.can_edit_concerts?
      end
    end
end
