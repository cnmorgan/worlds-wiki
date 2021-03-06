module ApplicationHelper

  include SessionsHelper

  def check_site_admin
    unless site_admin?
      flash[:danger] = "You must have site admin privileges to access that."
      redirect_to root_url
    end
  end

  def site_admin?
      current_user && current_user.is_site_admin
  end


  def check_logged_in
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user_is(user)
    current_user && user && user.email && current_user.email == user.email
  end 

  def decode(text)
    CGI::unescape(text)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def get_world

    @world = World.find_by(name: "Worlds Wiki")

    if params[:world_name]
      @world = World.find_by(name: params[:world_name])
    end

    return @world

  end

  def check_private
    get_world

    if @world && @world.is_private?
      unless @world.is_admin?(current_user)
        flash[:warning] = "That world is private. You must be an admin to view."
        redirect_to root_path 
      end
    end

  end

end
