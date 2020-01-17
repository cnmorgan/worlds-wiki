class PagesController < ApplicationController

  include ApplicationHelper
  include SessionsHelper
  include PagesHelper

  before_action :increment_view_count, only: [:show]

  def index
    @world = World.find_by(name: decode(params[:world_name]))
    @pages = @world.sub_wiki.pages
    @page_count = @pages.count
  end

  def new
    @world = World.find_by(name: decode(params[:world_name]))
    @page = Page.new
  end

  def create
    @world = World.find_by(name: decode(params[:world_name]))
    not_found if @world.nil?
    @page = Page.new(page_params)
    @page.sub_wiki_id = @world.sub_wiki.id;
    
    if @page.save
      flash[:success] = "Page Created"
      @page.categories << @world.sub_wiki.categories.find_by(name: params[:category]) if params[:category]
      redirect_to world_page_path(@world.name, @page.title)
    else
      flash[:errors] = @page.errors
      redirect_to new_world_page_path(@world.name)
    end

  end
  

  def edit
    @world = World.find_by(name: decode(params[:world_name]))
    not_found if @world.nil?
    @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))
  end

  def update
    @world = World.find_by(name: decode(params[:world_name]))
    not_found if @world.nil?
    @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))
    original_content = @page.content

    if @page.update(page_params)
      Edit.create!(page: @page, user: current_user, content: original_content) unless @page.content == original_content
      flash[:success] = "Page updated"
      redirect_to world_page_path(@world.name, @page.title)
    else
      flash[:errors] = @page.errors
      redirect_to edit_world_page_path(@world.name, params[:page_title])
    end
  end
  

  def show
    @world = World.find_by(name: decode(params[:world_name]))
    not_found if @world.nil?
    @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))
    not_found if @page.nil?

    @result = parse(@page.content, params)

    @sections = @result[:sections]
    @html = @result[:html]

    @summary = parse(@page.summary, params)[:html]

  end

  def destroy

    @world = World.find_by(name: decode(params[:world_name]))
    @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))

    @page.destroy

    redirect_to world_pages_path(decode(params[:world_name]))

  end

  def get_category
    @world = World.find_by(name: decode(params[:world_name]))
    @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))
  end
  

  def add_to_category
    @world = World.find_by(name: decode(params[:world_name]))
    @category = @world.categories.find_by(name: params[:category][:name])
    @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))

    if @category
      @page.categories << @category
      flash[:success] = "#{@page.title} added to #{@category.name}"
    elsif !params[:category][:name].nil? && !params[:category][:name].empty?
      @category = @world.sub_wiki.categories.create!(name: params[:category][:name])
      @page.categories << @category
      flash[:success] = "#{@page.title} added to new category, #{@category.name}"
    else
      flash[:errors] = {:name => ["cannot be blank"]}
      redirect_to new_world_page_category_path(params[:world_name], params[:page_title])
    end
    redirect_to world_page_path(@world.name, @page.title)

  end
  
  private

  def page_params
    params.require(:page).permit(:title, :summary, :content)
  end

  def increment_view_count
    @world = World.find_by(name: decode(params[:world_name]))
    @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))

    if @page
      @page.view_count += 1;
      @page.save
    end
  end
  
end
