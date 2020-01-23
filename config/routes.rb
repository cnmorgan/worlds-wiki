Rails.application.routes.draw do
  
  get 'edits/index'
  if Rails.env.production?
    get '404', :to => 'main#page_not_found'
  end
  scope format: false do
    scope :username => /[^\/]+/ do
      scope :world_name => /[^\/]+/ do
        scope :category_name => /[^\/]+/ do
          scope :page_title => /[^\/]+/ do
            scope :template_title => /[^\/]+/ do
            get 'password_resets/new'
            get 'password_resets/edit'
            root 'main#index'
            
            get     'login',   to: 'sessions#new', as: 'login'
            post    'login',   to: 'sessions#create'   
            delete  'logout',  to: 'sessions#destroy'

            get    '/users(.:format)' ,       to: 'users#index',  as: 'users'
            post   '/users' ,                 to: 'users#create'
            get    '/users/new' ,             to: 'users#new',    as: 'new_user'   
            get    '/users/:username/edit' ,  to: 'users#edit',   as: 'edit_user'           
            get    '/users/:username' ,       to: 'users#show',   as: 'user'
            patch  '/users/:username' ,       to: 'users#update'
            put    '/users/:username' ,       to: 'users#update'
            post   '/users/:username',        to: 'users#update'
            delete '/users/:username' ,       to: 'users#destroy'

            get    '/users/:username/templates(.:format)',              to: 'templates#index',  as: 'user_templates'
            post   '/users/:username/templates' ,                       to: 'templates#create'
            get    '/users/:username/templates/new' ,                   to: 'templates#new',    as: 'new_template'   
            get    '/users/:username/templates/find',                   to: 'templates#find',   as: 'find_template'
            get    '/users/:username/templates/:template_title/apply',  to: 'templates#apply',  as: 'apply_template'
            get    '/users/:username/templates/:template_title/edit' ,  to: 'templates#edit',   as: 'edit_template'           
            get    '/users/:username/templates/:template_title' ,       to: 'templates#show',   as: 'user_template'
            patch  '/users/:username/templates/:template_title' ,       to: 'templates#update'
            put    '/users/:username/templates/:template_title' ,       to: 'templates#update'
            post   '/users/:username/templates/:template_title',        to: 'templates#update'
            delete '/users/:username/templates/:template_title' ,       to: 'templates#destroy'
            
            get    '/users/:username/worlds',                   to: 'worlds#index', as: 'user_worlds'  
            post   '/users/:username/worlds',                   to: 'worlds#create'
            get    '/users/:username/worlds/new',               to: 'worlds#new',   as: 'new_user_world' 
            get    '/users/:username/worlds/:world_name/edit',  to: 'worlds#edit',  as: 'edit_user_world' 
            get    '/users/:username/worlds/:world_name' ,      to: 'worlds#show'                    
            get    'worlds/:world_name',                        to: 'worlds#show',  as: 'user_world'
            patch  '/worlds/:world_name' ,                      to: 'worlds#update'
            put    '/worlds/:world_name' ,                      to: 'worlds#update'
            delete '/worlds/:world_name' ,                      to: 'worlds#destroy'
            get    '/worlds',                                   to: 'worlds#all',   as: 'worlds'
            
            get    '/users/:username/worlds/:world_name/wiki/edit',  to: 'sub_wikis#edit', as: 'edit_world_wiki'
            get    '/users/:username/worlds/:world_name/wiki' ,      to: 'sub_wikis#show'                      
            get    'worlds/:world_name/wiki',                        to: 'sub_wikis#show', as: 'world_wiki'     
            patch  '/users/:username/worlds/:world_name/wiki' ,      to: 'sub_wikis#update'                     
            put    '/users/:username/worlds/:world_name/wiki' ,      to: 'sub_wikis#update'                    


            get    '/worlds/:world_name/wiki/categories(.:format)',                                 to: 'categories#index',       as: 'user_world_categories'
            post   '/worlds/:world_name/wiki/categories',                                           to: 'categories#create'     
            get    '/worlds/:world_name/wiki/categories/new',                                       to: 'categories#new',         as: 'new_user_world_category'
            get    '/worlds/:world_name/wiki/categories/:category_name/edit',                       to: 'categories#edit',        as: 'edit_user_world_category'
            get    '/worlds/:world_name/wiki/categories/:category_name',                            to: 'categories#show',        as: 'user_world_category'
            patch  '/worlds/:world_name/wiki/categories/:category_name' ,                           to: 'categories#update' 
            put    '/worlds/:world_name/wiki/categories/:category_name' ,                           to: 'categories#update' 
            delete '/worlds/:world_name/wiki/categories/:category_name' ,                           to: 'categories#destroy' 
            delete '/worlds/:world_name/wiki/categories/:category_name/remove/:page_title',         to: 'categories#remove_page', as: 'remove_page_from_category' 
            get    '/worlds/:world_name/wiki/categories/:category_name/add_page',                   to: 'categories#get_page',    as: 'add_page_to_category' 
            post    '/worlds/:world_name/wiki/categories/:category_name/add_page',                  to: 'categories#add_page'
            get    '/worlds/:world_name/wiki/categories/:category_name/add',                        to: 'categories#get_sub_cat', as: 'add_sub_category'
            post   '/worlds/:world_name/wiki/categories/:category_name/add',                        to: 'categories#add_sub_cat'
            delete '/worlds/:world_name/wiki/categories/:category_name/remove_cat/:sub_name',       to: 'categories#remove_sub_cat', as: 'remove_sub_category', sub_name: /[^\/]+/

            get    '/worlds/:world_name/wiki/pages(.:format)',                to: 'pages#index',                    as: 'world_pages'
            post   '/worlds/:world_name/wiki/pages',                          to: 'pages#create'             
            get    '/worlds/:world_name/wiki/pages/new',                      to: 'pages#new',                      as: 'new_world_page'
            get    '/worlds/:world_name/wiki/pages/:page_title/edit',         to: 'pages#edit',                     as: 'edit_world_page'
            get    '/worlds/:world_name/wiki/pages/:page_title',              to: 'pages#show',                     as: 'world_page'
            post   '/worlds/:world_name/wiki/pages/:page_title' ,             to: 'pages#update'          
            put    '/worlds/:world_name/wiki/pages/:page_title' ,             to: 'pages#update'          
            delete '/worlds/:world_name/wiki/pages/:page_title' ,             to: 'pages#destroy'         
            post   '/worlds/:world_name/wiki/pages/:page_title/add-category', to: 'pages#add_to_category'         
            get    '/worlds/:world_name/wiki/pages/:page_title/add-category', to: 'pages#get_category',             as: 'new_world_page_category'
            get    '/worlds/:world_name/wiki/search',                         to: 'pages#search',                   as: 'page_search'

            get    '/worlds/:world_name/admins/new',              to: 'admins#new',    as: 'new_world_admin'
            post   '/worlds/:world_name/admins',                  to: 'admins#create', as: 'create_world_admin'
            delete '/worlds/:world_name/admins/:username',        to: 'admins#destroy',as: 'destroy_world_admin', format: false

            get     'account_activation/:id/edit', to: 'account_activations#edit', as: 'account_activation'

            get    '/worlds/:world_name/wiki/pages/:page_title/edits', to: 'edits#index', as: 'page_edits'
            resources :password_resets,     only: [:new, :create, :edit, :update]
          end
        end
       end
      end
    end
  end

  get '.well-known/acme-challenge/:id', to: "main#certbot"
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
