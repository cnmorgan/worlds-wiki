class UsersController < ApplicationController

  include SessionsHelper
  include ApplicationHelper

  before_action :check_site_admin, only: [:destroy]
  before_action :check_user_privilege, only: [:edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
    @user.email.downcase!
    
    if @user.save
      # If user saves in the db successfully:
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      flash[:errors] = @user.errors
      redirect_to new_user_path
    end
  end

  def index
  end
  
  def show
    @user = User.find_by(username: decode(params[:username]))
    not_found if @user.nil?
  end
  
  def edit
    @user = User.find_by(username: decode(params[:username]))
    not_found if @user.nil?
  end
  
  def update
    @user = User.find_by(username: decode(params[:username]))
    not_found if @user.nil?

    @user.username = params[:user][:username]
    @user.email = params[:user][:email]

    if @user.save
      flash[:success] = "Successfully updated profile"
      redirect_to user_path(@user.username)
    else
      flash[:errors] = @user.errors
      redirect_to edit_user_path(decode(params[:username]))
    end

  end
  
  def destroy
    User.where(username: decode(params[:username])).destroy_all
    redirect_to users_path
  end
private

  def user_params
    # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
    # that can be submitted by a form to the user model #=> require(:user)
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def check_user_privilege
    if !current_user_is(User.find_by(username: decode(params[:username])))
      flash[:danger] = "You do not have persmission to do that"
      redirect_to root_path
    end
  end
  

end