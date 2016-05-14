class AddFolderToBookmarks < ActiveRecord::Migration
  def change
    add_reference :bookmarks, :folder, index: true, foreign_key: true
  end
end
