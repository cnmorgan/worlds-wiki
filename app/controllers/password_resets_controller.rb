class PasswordResetsController < ApplicationController

  include SessionsHelper

  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash[:danger] = "Email address not found"
      redirect_to new_password_reset_path
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?              
      @user.errors.add(:password, "can't be empty")
      flash[:errors] = @user.errors
      redirect_to edit_password_reset_path(params[:id], email: params[:email])
    elsif @user.update(user_params)                  
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to user_path(@user.username)
    else
      flash[:errors] = @user.errors
      redirect_to edit_password_reset_path(params[:id], email: params[:email])                                   
    end
  end

  private
    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # Checks expiration of reset token.
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end

end
