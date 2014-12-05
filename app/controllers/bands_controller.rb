class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy]

  def index
    @bands = Band.all
  end

  def show
  end

  def new
    @band = Band.new
  end

  def edit

  end

  def create
    @band = Band.new(band_params)

    if @band.save
      @band.update(identity_confirmed?: false)
      log_in @band
      flash[:success] = "Account created successfully! Please wait for our admin to confirm your identity, before start using our services."
      redirect_to 'root'
    else
      render :new
    end
  end

  def update
    if @band.update_attributes(band_params)
      flash[:success] = "Band was successfully updated." 
      redirect_to @band
    else
      render :edit
    end
  end

  def destroy
    @band.destroy
    flash[:success] = "Band was successfully destroyed."
    redirect_to bands_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_band
      @band = Band.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def band_params
      params.require(:band).permit(:bandname, :name, :bio, :website, :email, :password)
    end
end
