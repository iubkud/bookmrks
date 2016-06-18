class AccountActivationsController < ApplicationController
  respond_to :json
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      render :json => { :activated => "true",
                        :message   => "Account activated!" }
    else
      render :json => { :activated => "false",
                        :message   => "Error activating account." }
    end
  end
end
