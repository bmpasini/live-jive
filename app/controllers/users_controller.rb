class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
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
    flash[:success] = "User was successfully destroyed."
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :name, :year_of_birth, :email, :password, :city_of_birth)
    end
end
