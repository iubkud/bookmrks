require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:matt)
  end

  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should redirect to user if logged in" do
    log_in_as(@user)
    get :home
    assert_redirected_to @user   
  end
end
