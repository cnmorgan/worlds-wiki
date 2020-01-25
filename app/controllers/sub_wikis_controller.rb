class SubWikisController < ApplicationController

    include ApplicationHelper
    
    before_action :check_private

    def show
        not_found if @world.nil?
    end

    def edit
    end

    def update
    end

end
