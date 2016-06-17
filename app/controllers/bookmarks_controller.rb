class BookmarksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    if @bookmark.save
      render :json => { :created => "true",
                        :message => "Bookmark added!" }
    else
      render :json => { :created => "false",
                        :message => "There was an error adding the bookmark. Try again later." }
    end
  end

  def destroy
  end

  private

    def bookmark_params
      params.permit(:title, :url, :folder_id, :tag_list)
    end
end
