require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:matt)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_match @user.bookmarks.count.to_s, response.body
  end
end
