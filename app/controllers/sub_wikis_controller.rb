class SubWikisController < ApplicationController

    include ApplicationHelper

    def show
        @world = World.find_by(name: decode(params[:world_name]))
        not_found if @world.nil?
    end

    def edit
    end

    def update
    end

end
