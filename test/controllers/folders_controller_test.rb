require 'test_helper'

class FoldersControllerTest < ActionController::TestCase
  def setup
    @user = users(:matt)
    @other_user = users(:archer)
    @folder = folders(:one)
  end

  test "should show current users folders" do
    log_in_as(@user)
    get :show, id: @folder
    assert_response :success
  end
  
  test "should not be able to view others folders" do
    log_in_as(@other_user)
    get :show, id: @folder
    parsed_response = JSON.parse(@response.body)
    assert_equal "forbidden", parsed_response['status']
  end
end
