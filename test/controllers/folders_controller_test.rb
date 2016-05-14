require 'test_helper'

class FoldersControllerTest < ActionController::TestCase
  def setup
    @user = users(:matt)
    @other_user = users(:archer)
    @folder = folders(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Folder.count' do
      post :create, folder: { name: "Test test test" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Folder.count' do
      delete :destroy, id: @folder
    end
    assert_redirected_to login_url
  end

  test "should show current users folders" do
    log_in_as(@user)
    get :show, id: @folder
    assert_response :success
  end
  
  test "should not be able to view others folders" do
    log_in_as(@other_user)
    get :show, id: @folder
    assert_redirected_to root_url
  end
end
