require 'test_helper'

class FolderTest < ActiveSupport::TestCase
  def setup
    @user = users(:matt)
    @folder = @user.folders.build(name: "Test Folder")
  end

  test "should be valid" do
    assert @folder.valid?
  end

  test "user id should be present" do
    @folder.user_id = nil
    assert_not @folder.valid?
  end

  test "name should be present" do
    @folder.name = "   "
    assert_not @folder.valid?
  end

  test "name should be 256 chars or less" do
    @folder.name = "a" * 257
    assert_not @folder.valid?
  end
end
