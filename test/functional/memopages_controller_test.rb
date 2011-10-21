require 'test_helper'

class MemopagesControllerTest < ActionController::TestCase
  setup do
    @memopage = memopages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:memopages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create memopage" do
    assert_difference('Memopage.count') do
      post :create, memopage: @memopage.attributes
    end

    assert_redirected_to memopage_path(assigns(:memopage))
  end

  test "should show memopage" do
    get :show, id: @memopage.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @memopage.to_param
    assert_response :success
  end

  test "should update memopage" do
    put :update, id: @memopage.to_param, memopage: @memopage.attributes
    assert_redirected_to memopage_path(assigns(:memopage))
  end

  test "should destroy memopage" do
    assert_difference('Memopage.count', -1) do
      delete :destroy, id: @memopage.to_param
    end

    assert_redirected_to memopages_path
  end
end
