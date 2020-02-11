class WorldsController < ApplicationController
  include SessionsHelper
  include ApplicationHelper
  
  # before_action :check_site_admin, only: [:index, :destroy]
  before_action :check_logged_in, except: [:show, :index, :all]
  before_action :check_admin, only: [:edit]
  before_action :check_private

  def all 
  end

  def index
    @user = User.find_by(username: decode(params[:username]))
    not_found if @user.nil?
  end
  
  def new
    @new_world = World.new

    #stub. In the future this should be determined by user status
    if current_user.owned_worlds.count == 3
      flash[:info] = "You have reached your maximum number of worlds. (#{current_user.owned_worlds.count})"
      redirect_to user_path(current_user.username)
    else
  end

  def create

    @owner = User.find_by(username: params[:username])

      @world = World.new(name: world_params[:name], is_private: world_params[:is_private], owner: @owner)
      
      if @world.save
        # If user saves in the db successfully:
        flash[:success] = "Successfully Created #{@world.name}"
        redirect_to user_world_path(@world.name)
      else
        # If user fails model validation - probably a bad password or duplicate email:
        flash[:errors] = @world.errors
        redirect_to new_user_world_path(params[:username])
      end
    end
  end
  
  def edit
    @world = World.find_by(name: params[:world_name])
  end

  def update

    if @world.update(name: world_params[:name], is_private: world_params[:is_private])
      flash[:success] = "Successfully Update #{@world.name}"
      redirect_to user_world_path(@world.name)
    else
      flash[:errors] = @world.errors
      redirect_to edit_user_world_path(@world.owner.username, params[:world_name])
    end
  end

  def destroy
    owner = @world.owner
    @world.destroy

    redirect_to user_path(owner.username)
  end

  def show
  end

  
  private
    def world_params
      # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
      # that can be submitted by a form to the user model #=> require(:user)
      params.require(:world).permit(:name, :is_private)
    end

    def check_admin
      unless current_user.admin_worlds.find_by(name: params[:world_name])
        flash[:danger] = "You don't have permissions to do that"
        redirect_to user_world_path(params[:world_name])
      end
    end
    

end
