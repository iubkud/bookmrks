class FoldersController < ApplicationController
  before_action :logged_in_user,    only: [:show, :create, :destroy]
  before_action :user_owns_folders, only: [:show, :create, :destroy]
  def show
    @folder = Folder.find(params[:id])
    @bookmarks = @folder.bookmarks
  end

  def create
    @folder = current_user.folders.build(folder_params)
    if @folder.save
      flash[:success] = "Folder added!"
      redirect_to :back
    else
      flash[:danger] = "Something went wrong!"
      redirect_to :back
    end
  end

  def destroy
  end

  private
    def folder_params
      params.require(:folder).permit(:name)
    end

    def user_owns_folders
      @folder = Folder.find(params[:id])
      redirect_to root_url unless current_user.id == @folder.user_id
    end

end
