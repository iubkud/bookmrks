require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  def setup
    @user = users(:matt)
    @bookmark = @user.bookmarks.build(title: "Lorem Ipsum", url: "http://www.google.com", folder_id: 1)
  end

  test "should be valid" do
    assert @bookmark.valid?
  end

  test "user id should be present" do
    @bookmark.user_id = nil
    assert_not @bookmark.valid?
  end

  test "title should be present" do
    @bookmark.title = "   "
    assert_not @bookmark.valid?
  end

  test "title should be at most 256 characters" do
    @bookmark.title = "a" * 257
    assert_not @bookmark.valid?
  end

  test "sort bookmarks by my recent first" do
    assert_equal bookmarks(:most_recent), Bookmark.first
  end

  test "url must be not be invalid" do
    @bookmark.url = "foo.com"
    assert_not @bookmark.valid?
  end

  test "must accept valid urls" do
    @bookmark.url = "http://www.google.com"
    assert @bookmark.valid?
  end
end
