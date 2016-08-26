require 'test_helper'

class FinanceApiControllerTest < ActionController::TestCase
  test "should get responce-status" do
    get :responce-status
    assert_response :success
  end

  test "should get success" do
    get :success
    assert_response :success
  end

  test "should get error" do
    get :error
    assert_response :success
  end

end
