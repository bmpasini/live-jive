class ConcertsController < ApplicationController
  before_action :set_concert, only: [:show, :edit, :update, :destroy]

  def index
    @concerts = Concert.paginate(page: params[:page])
  end

  def show
  end

  def new
    @concert = Concert.new
  end

  def edit
  end

  def get_bands(band_ids)
    bands = Array.new
    band_ids[:band_ids].each_with_index do |band_id, i|
      p bands << Band.find(band_id.to_i) if i == 1
    end
    bands
  end

  def set_lineups(concert, bands)
    bands.each do |band|
      concert.set_lineup(band)
    end
  end

  def create
    @concert = Concert.new(concert_params)

    if @concert.save
      p "********"
      concert_params
      p "********"
      p band_ids_params
      p "********"
      p bands = get_bands(band_ids_params)
      p "********"
      set_lineups(@concert, bands)
      redirect_to @concert
      flash[:success] = 'Concert was successfully created.'
    else
      render :new
    end
  end

  def update
    if @concert.update(concert_params)
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
end
