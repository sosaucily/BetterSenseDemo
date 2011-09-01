require 'test_helper'

class TagControllerTest < ActionController::TestCase
  test "should get deliver" do
    get :deliver
    assert_response :success
  end

  test "should get display" do
    get :display
    assert_response :success
  end

end
