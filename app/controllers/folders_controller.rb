class FoldersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

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

end
