class FoldersController < ApplicationController
  before_action :logged_in_user,    only: [:show, :create, :destroy]
  before_action :user_owns_folders, only: :show
  respond_to :json
  
  def show
    @folder = Folder.find(params[:id])
    @bookmarks = @folder.bookmarks
    render :json => { :folder    => @folder,
                      :bookmarks => @bookmarks }
  end

  def create
    @folder = current_user.folders.build(folder_params)
    if @folder.save
      render :json => { :created => "true",
                        :message => "Your folder #{@folder.name} was successfully added." }
    else
      render :json => { :created => "false",
                        :message => "There was an error. Please try again later." }
    end
  end

  def edit
    @folder = Folder.find(params[:id])
  end

  def update
    @folder = Folder.find(params[:id])
    if @folder.update_attributes(folder_params)
      render :json => { :created => "true",
                        :message => "The folder #{@folder.name} was updated." }
    else
      render :json => { :created => "false",
                        :message => "There was an error. Please try again later." }
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
      render :json => { :status => :forbidden, :message => "You do not have access to this folder." } unless current_user.id == @folder.user_id
    end

end
