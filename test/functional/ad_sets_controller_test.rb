require 'test_helper'

class AdSetsControllerTest < ActionController::TestCase
  setup do
    @ad_set = ad_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ad_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ad_set" do
    assert_difference('AdSet.count') do
      post :create, :ad_set => @ad_set.attributes
    end

    assert_redirected_to ad_set_path(assigns(:ad_set))
  end

  test "should show ad_set" do
    get :show, :id => @ad_set.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ad_set.to_param
    assert_response :success
  end

  test "should update ad_set" do
    put :update, :id => @ad_set.to_param, :ad_set => @ad_set.attributes
    assert_redirected_to ad_set_path(assigns(:ad_set))
  end

  test "should destroy ad_set" do
    assert_difference('AdSet.count', -1) do
      delete :destroy, :id => @ad_set.to_param
    end

    assert_redirected_to ad_sets_path
  end
end
