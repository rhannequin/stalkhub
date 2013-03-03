require 'test_helper'

class StalkingsControllerTest < ActionController::TestCase
  setup do
    @stalking = stalkings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stalkings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stalking" do
    assert_difference('Stalking.count') do
      post :create, stalking: { user_id: @stalking.user_id, owner: @stalking.owner, repo: @stalking.repo }
    end

    assert_redirected_to stalking_path(assigns(:stalking))
  end

  test "should show stalking" do
    get :show, id: @stalking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stalking
    assert_response :success
  end

  test "should update stalking" do
    put :update, id: @stalking, stalking: { user_id: @stalking.user_id, owner: @stalking.owner, repo: @stalking.repo }
    assert_redirected_to stalking_path(assigns(:stalking))
  end

  test "should destroy stalking" do
    assert_difference('Stalking.count', -1) do
      delete :destroy, id: @stalking
    end

    assert_redirected_to stalkings_path
  end
end
