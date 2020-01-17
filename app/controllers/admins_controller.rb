class AdminsController < ApplicationController

    def new
        
    end

    def create
        @user = User.find_by(username: params[:admin][:username])
        @world = World.find_by(name: params[:world_name])
        if @user
            @world.make_admin(@user)
            flash[:success] = "Successfully made #{@user.username} an admin of #{@world.name}"
            redirect_to user_world_path(@world.name)
        else
            flash[:errors] = {:user => ["not found"]}
            redirect_to new_world_admin_path(@world.name)
        end
    end

    def destroy
        @user = User.find_by(username: params[:username])
        @world = World.find_by(name: params[:world_name])

        @user.admin_privileges.find_by(world_id: @world.id).destroy unless @user.username == @world.owner.username

        redirect_to user_world_path(@world.name)

    end
    
    

end
