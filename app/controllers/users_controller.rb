class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:show, :edit, :update]
  skip_before_action :verify_authenticity_token
  respond_to :json

  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks.paginate(page: params[:page])
    @folders = @user.folders
    render :json => { :user      => @user,
                      :bookmarks => @bookmarks,
                      :folders   => @folders,
                      status: :ok }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      render :json => { :created => "true",
                        :message => "Please check your email to activate your account." }
    else
      render :json => { :created => "false",
                        :message => "A problem occured. Please try again later." }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render :json => { :updated => "true" }
    else
      render :json => { :updated => "false",
                        :user_errors => @user.errors }
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
