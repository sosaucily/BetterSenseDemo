require 'test_helper'

class BetterpicControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get info" do
    get :info
    assert_response :success
  end

end
