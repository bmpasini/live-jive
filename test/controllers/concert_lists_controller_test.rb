require 'test_helper'

class ConcertListsControllerTest < ActionController::TestCase
  setup do
    @concert_list = concert_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:concert_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create concert_list" do
    assert_difference('ConcertList.count') do
      post :create, concert_list: { description: @concert_list.description, list_owner_id: @concert_list.list_owner_id, title: @concert_list.title }
    end

    assert_redirected_to concert_list_path(assigns(:concert_list))
  end

  test "should show concert_list" do
    get :show, id: @concert_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @concert_list
    assert_response :success
  end

  test "should update concert_list" do
    patch :update, id: @concert_list, concert_list: { description: @concert_list.description, list_owner_id: @concert_list.list_owner_id, title: @concert_list.title }
    assert_redirected_to concert_list_path(assigns(:concert_list))
  end

  test "should destroy concert_list" do
    assert_difference('ConcertList.count', -1) do
      delete :destroy, id: @concert_list
    end

    assert_redirected_to concert_lists_path
  end
end
