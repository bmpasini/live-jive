class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :correct_user]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :favorite_bands]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    debugger
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    session[:band_id] = nil
    @user = User.new(user_params)

    if @user.save
      @user.update(is_admin?: false, reputation_score: 0)
      log_in @user
      flash[:success] = "Welcome to LiveJive!"
      redirect_to @user
    else
      render :new
    end
 
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "User was successfully updated." 
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User was successfully deleted."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def favorite_bands
    @title = "Favorite Bands"
    @user  = User.find(params[:id])
    @bands = @user.favorite_bands.paginate(page: params[:page])
    render 'show_favorite_bands'
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

    # Confirms the correct user.
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.is_admin?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :name, :year_of_birth, :email, :password, :city_of_birth)
    end
end
