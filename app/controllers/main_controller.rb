class MainController < ApplicationController
  def index
  end

  def page_not_found
  end

  def certbot
    render plain: "sTNQ2c4tjJC6xRuS0QZmkZAGiQL94hBEYtozrq6l1gc.9paInSbgGKnJWSnqIBI2BGJ265TadJ9i3PJCPJGLFIE", layout: false, content_type: 'text/plain'
  end

end
