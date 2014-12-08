class ConcertListsController < ApplicationController
  before_action :set_concert_list, only: [:show, :edit, :update, :destroy]

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
    @concert_list = current_user.build(concert_list_params)
    if @concert_list.save
      redirect_to @concert_list, notice: 'Concert list was successfully created.'
    else
      render :new
    end
  end

  def update
    if @concert_list.update(concert_list_params)
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

    # Confirms the correct user.
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
end
