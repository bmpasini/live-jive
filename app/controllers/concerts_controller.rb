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

  def create
    @concert = Concert.new(concert_params)

    if @concert.save
      redirect_to @concert, notice: 'Concert was successfully created.'
    else
      render :new
    end
  end

  def update
    if @concert.update(concert_params)
      redirect_to @concert, notice: 'Concert was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @concert.destroy
    redirect_to concerts_url, notice: 'Concert was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concert
      @concert = Concert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concert_params
      params.require(:concert).permit(:cdate, :ctime, :location_name, :ccity, :buy_tickets_website)
    end
end
