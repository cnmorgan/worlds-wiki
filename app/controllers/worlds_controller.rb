class WorldsController < ApplicationController
  include SessionsHelper
  include ApplicationHelper
  
  # before_action :check_site_admin, only: [:index, :destroy]
  before_action :check_logged_in, except: [:show, :index, :all]
  before_action :check_admin, only: [:edit]

  def all 
  end

  def index
    @user = User.find_by(username: decode(params[:username]))
    not_found if @user.nil?
  end
  
  def new
    @world = World.new
  end

  def create
    @owner = User.find_by(username: params[:username])
    @world = World.new(name: world_params[:name], owner: @owner)
    
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
  
  def edit
    @world = World.find_by(name: params[:world_name])
  end

  def update
    @world = World.find_by(name: params[:world_name])

    if @world.update(name: world_params[:name])
      flash[:success] = "Successfully Update #{@world.name}"
      redirect_to user_world_path(@world.name)
    else
      flash[:errors] = @world.errors
      redirect_to edit_user_world_path(@world.owner.username, params[:world_name])
    end
  end

  def destroy
    world = World.find_by(name: decode(params[:world_name]))
    owner = world.owner
    world.destroy

    redirect_to user_path(owner.username)
  end

  def show
    @world = World.find_by(name: decode(params[:world_name]))
  end

  
  private
    def world_params
      # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
      # that can be submitted by a form to the user model #=> require(:user)
      params.require(:world).permit(:name)
    end

    def check_admin
      unless current_user.admin_worlds.find_by(name: params[:world_name])
        flash[:danger] = "You don't have permissions to do that"
        redirect_to user_world_path(params[:world_name])
      end
    end
    

end
