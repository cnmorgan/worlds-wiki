class EditsController < ApplicationController

  include ApplicationHelper

  def index
    @world = World.find_by(name: params[:world_name])
    not_found unless @world
    @page = @world.sub_wiki.pages.find_by(title: params[:page_title])
    not_found unless @page

    params[:page] = 1 unless params[:page]
    @edits = @page.edits.paginate(page: params[:page], per_page: 30)
  end
end
