require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  def setup
    @bookmark = bookmarks(:google)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Bookmark.count' do
      post :create, bookmark: { title: 'Lorem ipsum' }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Bookmark.count' do
      delete :destroy, id: @bookmark
    end
    assert_redirected_to login_url
  end
end
