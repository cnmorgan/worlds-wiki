class PagesController < ApplicationController

  include ApplicationHelper
  include SessionsHelper
  include PagesHelper

  require 'will_paginate/array'

  before_action :increment_view_count, only: [:show]
  before_action :check_private

  def index
    @pages = @world.sub_wiki.pages
    @page_count = @pages.count

    respond_to do |format|
      format.html
      format.json {
        term = params[:q]
        response = []
        @pages.pluck(:title).each do |title|
          if title.downcase.include?(term.downcase)
            response << title
          end
        end
        render json: response
      }
    end
  end

  def new
    @page = Page.new

    if params[:template]
      @template = current_user.templates.find_by(title: params[:template])
      @default_title = ""
    end

    if @template
      @default_content = @template.content
    elsif params[:title]
      @draft = @world.sub_wiki.pages.find_by(title: params[:title]+"-Preview")
      @default_content = @draft.content
      @default_title = @draft.title.delete_suffix("-Preview")
    else
      @default_content = ""
      @default_title = ""
    end
    # Stub, change to value based un subscription in the future
    if @world.sub_wiki.pages.count > 99
      flash[:info] = "You have reached the maximum number of pages(#{@world.sub_wiki.pages.count}) for this world."
      redirect_to world_wiki_path(@world.name)
    end
  end

  def create
    if params[:commit] == "Preview"
      preview_redirect(params[:page][:title], params[:page][:content], "create")

      unless performed?
        flash[:errors] = @page.errors
        redirect_to new_world_page_path(@world.name, title: params[:page][:title])
      end

    else
      @page = Page.new(page_params)
      @page.sub_wiki_id = @world.sub_wiki.id;

      if @page.save
        flash[:success] = "Page Created"
        @page.categories << @world.sub_wiki.categories.find_by(name: params[:category]) if params[:category]
        redirect_to world_page_path(@world.name, @page.title)
      else
        flash[:errors] = @page.errors
        @default_content = @page.content
        @default_title = @page.title
        render :new
        # redirect_to new_world_page_path(@world.name)
      end
    end
  end
  

  def edit
    not_found if @world.nil?
    @page = @world.sub_wiki.pages.find_by(title: params[:page_title])

    if params[:draft]
      @draft = @world.sub_wiki.pages.find_by(title: params[:page_title] + "-Preview")
    end

    @defaults = { title: @page.title, content: @page.content }

    @defaults = { title: @page.title, content: @draft.content } if @draft
  end

  def update

    if params[:commit] == "Preview"
      preview_redirect(params[:page_title], params[:page_edit][:content], "edit")

      unless performed?
        flash[:errors] = @page.errors
        redirect_to edit_world_page_path(@world.name, params[:page_title])
      end

    else
      not_found if @world.nil?
      @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))

      #if no edits have been made then just return with a success
      if params[:page_edit][:title] == @page.title && params[:page_edit][:content] == @page.content
        flash[:success] = "Page updated"
        redirect_to world_page_path(@world.name, @page.title)
      else

        original_content = @page.content
        @page.title   = params[:page_edit][:title]
        @page.content = params[:page_edit][:content]

        unless params[:page_edit][:edit_summary].empty?
          if @page.save
            Edit.create!(page: @page, user: current_user, content: original_content, summary: params[:page_edit][:edit_summary])
            flash[:success] = "Page updated"
            redirect_to world_page_path(@world.name, @page.title)
          else
            flash[:errors] = @page.errors
            redirect_to edit_world_page_path(@world.name, params[:page_title])
          end
        else
          flash.now[:errors] = {"edit summary" => ["cannot be blank"]}
          @defaults = {title: @page.title, content: @page.content}
          render :edit
        end
      end
    end
  end
  

  def show

    if params[:draft]
      @page = @world.sub_wiki.pages.find_by(title: params[:page_title], is_draft: true)
      @html = parse(@page.content)
      @origin = params[:origin]
      if @origin == "edit"
        @origin_url = edit_world_page_path(@world.name, @page.title.delete_suffix('-Preview'), draft: true)
      elsif @origin == "create"
        @origin_url = new_world_page_path(@world.name, title: @page.title.delete_suffix('-Preview'))
      end
      render 'page_preview'
    else
      @html = parse(@page.content)
      @page = @world.sub_wiki.pages.find_by(title: params[:page_title], is_draft: false)
    end

    if @page.nil?
      render :no_page
      return
    end

  end

  def no_page
  end

  def destroy

    @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))

    @page.destroy

    flash[:success] = "Page successfully deleted."

    redirect_to world_wiki_path(decode(params[:world_name]))

  end

  def get_category
    @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))
  end
  

  def add_to_category
    @category = @world.sub_wiki.categories.find_by(name: params[:category][:name])
    @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))

    if @category
      #dont add it to a category twice
      unless @page.categories.exists?(@category.id)
        @page.categories << @category
      end
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
  
  def search
    unless params[:page]
      params[:page] = 1
    end

    title_fit = []
    content_fit = []

    @world.sub_wiki.pages.find_each do |page|
      if page.title.downcase.include?(params[:search].downcase)
        title_fit << page
      end
    end
    @world.sub_wiki.pages.find_each do |page|
      if page.content.downcase.include?(params[:search].downcase)
        content_fit << page
      end
    end

    best_fit = title_fit & content_fit
    all_fits = best_fit + ((title_fit + content_fit) - (best_fit))
    puts all_fits.to_s.yellow
    all_fits = all_fits.map {|page| {title: page.title}}

    @pages = all_fits.paginate(page: params[:page], per_page: 15)
    
  end

  private

  def page_params
    params.require(:page).permit(:title, :content)
  end

  def increment_view_count
    @world = World.find_by(name: decode(params[:world_name]))
    @page = @world.sub_wiki.pages.find_by(title: decode(params[:page_title]))

    if @page
      @page.view_count += 1;
      @page.save
    end
  end

  def preview_redirect(original_title, content, origin)
    title = original_title + "-Preview" unless original_title.blank?
    Page.where(is_draft: true).destroy_all
    @page = Page.create(title: title, content: content, sub_wiki: @world.sub_wiki, is_draft: true)
    redirect_to world_page_path(@world.name, @page.title, draft: true, origin: origin) unless @page.errors.any?
  end
  
end
