class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :correct_user, :concert_lists]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :favorite_bands]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :if_logged_in, only: :new

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @concert_lists = @user.concert_lists.paginate(page: params[:page], per_page: 10)
    if current_user?(@user)
      @concerts_users = @user.concerts_from_followed_users_who_like_the_same_genres
      @concerts_system = Array.new
      @concerts_system += @user.popular_concerts_from_users_who_like_the_same_genres unless @user.popular_concerts_from_users_who_like_the_same_genres.nil?
      @concerts_system += @user.top_recommended_concerts unless @user.top_recommended_concerts.nil?
      @concerts_system += @user.concerts_recommended_by_users_with_similar_tastes unless @user.concerts_recommended_by_users_with_similar_tastes.nil?
      @bands_popular = @user.popular_bands_that_play_genres_the_user_like
      @bands_with_good_concerts = @user.bands_with_good_concerts_that_play_genres_the_user_like
    end
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
      genres = get_genres(genre_ids_params)
      set_genres(@user, genres)
      log_in @user
      flash[:success] = "Welcome to LiveJive!"
      redirect_to @user
    else
      render :new
    end
 
  end

  def update
    if @user.update_attributes(user_params)
      genres = get_genres(genre_ids_params)
      set_genres(@user, genres)
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
    @users = @bands
    render 'show_favorite_bands'
  end

  def concerts
    @title = "Concert RSVPs"
    @user  = User.find(params[:id])
    @concerts = @user.concerts.paginate(page: params[:page])
    @users = @concerts
    render 'show_concert_goings'
  end

  def concert_lists
    @concert_lists = @user.concert_lists.paginate(page: params[:page], per_page: 10)
  end

  private
    def set_genres(user, genres)
      genres.each do |genre|
        user.set_genre(genre)
      end
    end

    def get_genres(genre_ids)
      genres = Array.new
      genre_ids[:genre_ids].each do |genre_id|
        p genre_id
        p genres << Genre.find(genre_id.to_i) unless genre_id == ""
      end
      genres
    end

    def if_logged_in
      redirect_to root_url if logged_in?
    end

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

    def genre_ids_params
      params.require(:user).permit(genre_ids: [])
    end
end
