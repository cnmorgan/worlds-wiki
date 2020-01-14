class MainController < ApplicationController
  def index
    @world = World.find_by(name: "Worlds Wiki")

    if @world
      @page = @world.sub_wiki.pages.find_by(title: "Welcome")
      if @page
        redirect_to world_page_path(@world.name, @page.title)
      else
        redirect_to user_world_path(@world.name)
      end
    end

  end

  def page_not_found
  end

  def certbot
    render plain: "sTNQ2c4tjJC6xRuS0QZmkZAGiQL94hBEYtozrq6l1gc.9paInSbgGKnJWSnqIBI2BGJ265TadJ9i3PJCPJGLFIE", layout: false, content_type: 'text/plain'
  end

end
