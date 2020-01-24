class CategoriesController < ApplicationController

  include ApplicationHelper

  def index
    @world = World.find_by(name: decode(params[:world_name]))

    respond_to do |format|
      format.html
      format.json {
        term = params[:q]
        response = []
        @world.sub_wiki.categories.pluck(:name).each do |name|
          if name.downcase.include?(term.downcase)
            response << name
          end
        end
        render json: response
      }
    end

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

    # Stub, change to value based un subscription in the future
    if @world.sub_wiki.categories.count > 34
      flash[:info] = "You have reached the maximum number of categories(#{@world.sub_wiki.categories.count}) for this world."
      redirect_to world_wiki_path(@world.name)
    end
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
    @category = @world.sub_wiki.categories.find_by(name: params[:category_name])  
    @page = @world.sub_wiki.pages.find_by(title: params[:page_title])

    @category.pages.delete(@page)
    
    flash[:success] = "#{@page.title} removed from #{@category.name}"

    redirect_to world_page_path(@world.name, @page.title)

  end

  def get_page
    @world = World.find_by(name: decode(params[:world_name]))
    @category = @world.sub_wiki.categories.find_by(name: params[:category_name])  
  end

  def add_page
    @world = World.find_by(name: decode(params[:world_name]))
    @page = @world.sub_wiki.pages.find_by(title: params[:find_page][:title])
    @category = @world.sub_wiki.categories.find_by(name: params[:category_name])

    if @page
      if @category.pages.find_by(title: @page.title)
        flash[:errors] = { :category => ["already contains page"] }
        redirect_to add_page_to_category_path(@world.name, @category.name)
      else
        @category.pages << @page
        flash[:success] = "Successfully added #{@page.title} to #{@category.name}"
        redirect_to user_world_category_path(@world.name, @category.name)
      end
    else
      flash[:errors] = { :page => ["not found"] }
      redirect_to add_page_to_category_path(@world.name, @category.name)
    end

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
      #don't add self as sub category
      if @category.name == @sub_category.name
        flash[:errors] = {"" => ["Cannot add category to itself"]}
        redirect_to add_sub_category_path(params[:world_name], params[:category_name])
        return
      end
      #Only allow one parent category
      if @sub_category.category
        flash[:errors] = {:category => ["already has parent category"]}
        redirect_to add_sub_category_path(params[:world_name], params[:category_name])
        return
      end
      # Dont add a sub category twice
      unless @category.sub_categories.exists?(@sub_category.id)
        @category.sub_categories << @sub_category
      end
      flash[:success] = "#{@sub_category.name} added to #{@category.name}"
    elsif !params[:category][:name].nil? && !params[:category][:name].empty?
      # If the queried category does not exist, create it
      @sub_category = @world.sub_wiki.categories.create!(name: params[:category][:name])
      @category.sub_categories << @sub_category
      flash[:success] = "#{@sub_category.name} added to category, #{@category.name}"
    else
      flash[:errors] = {:name => ["Name cannot be empty"]}
      redirect_to add_sub_category_path(params[:world_name], params[:category_name])
    end
    redirect_to user_world_category_path(@world.name, @category.name)
  end

  def remove_sub_cat
    @world = World.find_by(name: decode(params[:world_name]))
    @sub_category = @world.sub_wiki.categories.find_by(name: params[:sub_name])
    @category = @world.sub_wiki.categories.find_by(name: params[:category_name])

    @category.sub_categories.delete(@sub_category)

    flash[:success] = "Successfully removed #{@sub_category.name} as sub category"

    redirect_to user_world_category_path(@world.name, @category.name)

  end
  
  

  private

    def category_params
      params.require(:category).permit(:name, :sub_wiki_id)
    end
    


end
