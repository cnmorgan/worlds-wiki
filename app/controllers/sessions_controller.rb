class SessionsController < ApplicationController

  include SessionsHelper
  include ApplicationHelper

  before_action :check_private

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if !user
      flash.now[:danger] = "Invalid Email"
      render "new"
    elsif !user.authenticated?(:password, params[:session][:password])
      flash.now[:danger] = "Invalid password"
      render "new"
    else
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user_path(user.username)
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end

    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Successfully logged out"
    redirect_to root_url
  end

end
