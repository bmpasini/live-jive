require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { city_of_birth: @user.city_of_birth, current_login_at: @user.current_login_at, email: @user.email, is_admin?: @user.is_admin?, last_login_at: @user.last_login_at, name: @user.name, password: @user.password, reputation_score: @user.reputation_score, username: @user.username, year_of_birth: @user.year_of_birth }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { city_of_birth: @user.city_of_birth, current_login_at: @user.current_login_at, email: @user.email, is_admin?: @user.is_admin?, last_login_at: @user.last_login_at, name: @user.name, password: @user.password, reputation_score: @user.reputation_score, username: @user.username, year_of_birth: @user.year_of_birth }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
