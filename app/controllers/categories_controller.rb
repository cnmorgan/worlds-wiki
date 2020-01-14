class CategoriesController < ApplicationController

  include ApplicationHelper

  def index
    @world = World.find_by(name: decode(params[:world_name]))
  end

  def show
    @world = World.find_by(name: decode(params[:world_name]))
    @category = @world.sub_wiki.categories.find_by(name: decode(params[:category_name]))
    not_found if @world.nil? || @category.nil?
    @user = @world.owner
  end

  def edit
    @world = World.find_by(name: decode(params[:world_name]))
    @category = @world.sub_wiki.categories.find_by(name: decode(params[:category_name]))  
  end

  def update
    @category = Category.find_by(name:params[:category_name])

    if @category.update(category_params)
      flash[:success] = "Successfully updated category: #{@category.name}"
      redirect_to user_world_category_path(params[:world_name], @category.name)
    else
      flash[:errors] = @category.errors
      redirect_to new_user_world_category_path(params[:world_name])
    end
  end

  def new
    @category = Category.new
    @world = World.find_by(name: decode(params[:world_name]))
  end

  def create
    @category = Category.new(category_params)
    @world = World.find_by(name: params[:world_name])

    @category.sub_wiki_id = @world.sub_wiki.id

    if @category.save
      flash[:success] = "Successfully created category: #{@category.name}"
      redirect_to user_world_category_path(@world.name, @category.name)
    else
      flash[:errors] = @category.errors
      redirect_to new_user_world_category_path(params[:world_name])
    end

  end

  def destroy
    @world = World.find_by(name: decode(params[:world_name]))
    @category = @world.sub_wiki.categories.find_by(name: decode(params[:category_name]))  
    @category.destroy

    redirect_to world_wiki_path(params[:world_name])

  end

  def remove_page
    @world = World.find_by(name: decode(params[:world_name]))
    @category = @world.sub_wiki.categories.find_by(name: decode(params[:category_name]))  
    @page = @world.sub_wiki.pages.find_by(title: params[:page_title])

    @category.pages.delete(@page)
    
    flash[:success] = "#{@page.title} removed from #{@category.name}"

    redirect_back_or user_world_category_path(@category.name)

  end

  def get_sub_cat
    @world = World.find_by(name: decode(params[:world_name]))
    @category = @world.sub_wiki.categories.find_by(name: decode(params[:category_name]))  
  end

  def add_sub_cat
    @world = World.find_by(name: decode(params[:world_name]))
    @sub_category = @world.sub_wiki.categories.find_by(name: params[:category][:name])
    @category = @world.sub_wiki.categories.find_by(name: params[:category_name])

    if @sub_category
      @category.sub_categories << @sub_category
      flash[:success] = "#{@sub_category.name} added to #{@category.name}"
    elsif !params[:category][:name].nil? && !params[:category][:name].empty?
      @sub_category = @world.sub_wiki.categories.create!(name: params[:category][:name])
      @category.sub_categories << @sub_category
      flash[:success] = "#{@sub_category.name} added to category, #{@category.name}"
    else
      flash[:errors] = {:name => ["Name cannot be empty"]}
      redirect_to add_sub_category_path(params[:world_name], params[:category_name])
    end
    redirect_to user_world_category_path(@world.name, @category.name)
  end
  
  

  private

    def category_params
      params.require(:category).permit(:name, :sub_wiki_id)
    end
    


end
