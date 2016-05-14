require 'test_helper'

class FoldersControllerTest < ActionController::TestCase
  def setup
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
end
