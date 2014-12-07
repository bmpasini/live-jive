class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy, :correct_band]
  before_action :logged_in_band, only: [:index, :edit, :update, :destroy]
  before_action :correct_band, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :if_logged_in, only: :new

  def index
    @bands = Band.paginate(page: params[:page])
  end

  def show
  end

  def new
    @band = Band.new
  end

  def edit
  end

  def create
    session[:user_id] = nil
    @band = Band.new(band_params)

    if @band.save
      @band.send_activation_email
      flash[:info] = "LiveJive must verify your identity. Please check your email."
      redirect_to root_url
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
    flash[:success] = "Band was successfully deleted."
    redirect_to bands_url
  end

  def fans
    @title = "Fans"
    @band  = Band.find(params[:id])
    @bands = @band.fans.paginate(page: params[:page])
    render 'show_fans'
  end

  private
    def if_logged_in
      redirect_to root_url if logged_in?
    end

    # Confirms a logged-in band.
    def logged_in_band
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to band_login_url
      end
    end

    # Confirms the correct band.
    def correct_band
      redirect_to(root_url) unless current_band?(@band)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.is_admin?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_band
      @band = Band.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def band_params
      params.require(:band).permit(:bandname, :name, :bio, :website, :email, :password)
    end
end
