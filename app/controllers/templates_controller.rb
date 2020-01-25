class TemplatesController < ApplicationController

    include ApplicationHelper
    include PagesHelper

    before_action :check_user
    before_action :get_world

    def index
        respond_to do |format|
            format.html
            format.json{
                term = params[:q]
                response = []
                @user.templates.pluck(:title).each do |name|
                  if name.downcase.include?(term.downcase)
                    response << name
                  end
                end
                render json: response
            }
        end
    end

    def show
        @template = @user.templates.find_by(title: params[:template_title])

        @html = parse(@template.content)
    end

    def new
        @page = Page.new

        if @user.templates.count > 9
            flash[:info] = "You have reached your maximum number of Templates"
            redirect_to user_path(@user.username)
        end
    end

    def create
        @page = Page.new(title: params[:page][:title], content: params[:page][:content], user_id: @user.id)
        if @page.save
            flash[:success] = "Template Created"
            redirect_to user_template_path(@user.username, @page.title)
        else
            flash[:errors] = @page.errors
            render :new
        end
    end

    def edit
        @template = @user.templates.find_by(title: params[:template_title])

        @defaults = {title: @template.title, content: @template.content}
    end
    
    def update
        @template = @user.templates.find_by(title: params[:template_title])

        #if no edits have been made then just return with a success
        if params[:page_edit][:title] == @template.title && params[:page_edit][:content] == @template.content
            flash[:success] = "Template updated"
            redirect_to user_template_path(@user.username, @template.title)
        else
    
            original_content = @template.content
            @template.title   = params[:page_edit][:title]
            @template.content = params[:page_edit][:content]
    

            if @template.save
                flash[:success] = "Page updated"
                redirect_to user_template_path(@user.username, @template.title)
            else
                flash[:errors] = @page.errors
                redirect_to edit_template_path(@user.username, params[:page_title])
            end
        end
    end

    def destroy
        @template = @user.templates.find_by(title: params[:template_title])

        @template.destroy

        flash[:success] = "Template destroyed"
        redirect_to user_templates_path(params[:username])
    end

    def find
        @template = @user.templates.find_by(title: params[:template][:title])
        if @template
            redirect_to apply_template_path(@user.username, @template.title, world: params[:template][:world])
        else
            redirect_to new_world_page_path(world_name: params[:template][:world])
        end
    end

    def apply
        @template = @user.templates.find_by(title: params[:template_title])
        redirect_to new_world_page_path(world_name: params[:world], template: @template.title)
    end
    
    private
        def check_user
            @user = User.find_by(username: params[:username])
            unless current_user_is(@user)
                flash[:error] = "You don't have permission to do that"
                redirect_to root_url
            end
        end

end
