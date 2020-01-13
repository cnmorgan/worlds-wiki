Rails.application.routes.draw do
  

  get 'password_resets/new'
  get 'password_resets/edit'
  root 'main#index'
  
  get     'login',   to: 'sessions#new', as: 'login'
  post    'login',   to: 'sessions#create'   
  delete  'logout',  to: 'sessions#destroy'

  get    '/users' ,                 to: 'users#index',  as: 'users'
  post   '/users' ,                 to: 'users#create'
  get    '/users/new' ,             to: 'users#new',    as: 'new_user'
  get    '/users/:username/edit' ,  to: 'users#edit',   as: 'edit_user', :constraints  => { :username => /[0-z\.]+/ }              
  get    '/users/:username' ,       to: 'users#show',   as: 'user',      :constraints  => { :username => /[0-z\.]+/ }            
  patch  '/users/:username' ,       to: 'users#update',                  :constraints  => { :username => /[0-z\.]+/ }
  put    '/users/:username' ,       to: 'users#update',                  :constraints  => { :username => /[0-z\.]+/ }
  delete '/users/:username' ,       to: 'users#destroy',                 :constraints  => { :username => /[0-z\.]+/ }
  
  get    '/users/:username/worlds',                   to: 'worlds#index', as: 'user_worlds',      :constraints  => { :username => /[0-z\.]+/ }
  post   '/users/:username/worlds',                   to: 'worlds#create'
  get    '/users/:username/worlds/new',               to: 'worlds#new',   as: 'new_user_world',   :constraints  => { :username => /[0-z\.]+/ }
  get    '/users/:username/worlds/:world_name/edit',  to: 'worlds#edit',  as: 'edit_user_world',  :constraints  => { :username => /[0-z\.]+/ }
  get    '/users/:username/worlds/:world_name' ,      to: 'worlds#show',                          :constraints  => { :username => /[0-z\.]+/ }
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


  get    '/worlds/:world_name/wiki/categories',                                   to: 'categories#index',       as: 'user_world_categories'
  post   '/worlds/:world_name/wiki/categories',                                   to: 'categories#create'     
  get    '/worlds/:world_name/wiki/categories/new',                               to: 'categories#new',         as: 'new_user_world_category'
  get    '/worlds/:world_name/wiki/categories/:category_name/edit',               to: 'categories#edit',        as: 'edit_user_world_category'
  get    '/worlds/:world_name/wiki/categories/:category_name',                    to: 'categories#show',        as: 'user_world_category'
  patch  '/worlds/:world_name/wiki/categories/:category_name' ,                   to: 'categories#update'
  put    '/worlds/:world_name/wiki/categories/:category_name' ,                   to: 'categories#update'
  delete '/worlds/:world_name/wiki/categories/:category_name' ,                   to: 'categories#destroy'
  delete '/worlds/:world_name/wiki/categories/:category_name/remove/:page_title', to: 'categories#remove_page', as: 'remove_page_from_category'

  get    '/worlds/:world_name/wiki/pages',                          to: 'pages#index',          as: 'world_pages'
  post   '/worlds/:world_name/wiki/pages',                          to: 'pages#create'          
  get    '/worlds/:world_name/wiki/pages/new',                      to: 'pages#new',            as: 'new_world_page'
  get    '/worlds/:world_name/wiki/pages/:page_title/edit',         to: 'pages#edit',           as: 'edit_world_page'
  get    '/worlds/:world_name/wiki/pages/:page_title',              to: 'pages#show',           as: 'world_page'
  patch  '/worlds/:world_name/wiki/pages/:page_title' ,             to: 'pages#update'
  put    '/worlds/:world_name/wiki/pages/:page_title' ,             to: 'pages#update'
  delete '/worlds/:world_name/wiki/pages/:page_title' ,             to: 'pages#destroy'
  post  '/worlds/:world_name/wiki/pages/:page_title/add-category',  to: 'pages#add_to_category'
  get    '/worlds/:world_name/wiki/pages/:page_title/add-category', to: 'pages#get_category',   as: 'new_world_page_category'

  get    '/worlds/:world_name/admins/new',              to: 'admins#new',    as: 'new_world_admin'
  post   '/worlds/:world_name/admins',                  to: 'admins#create', as: 'create_world_admin'
  delete '/worlds/:world_name/admins/:username',        to: 'admins#destroy',as: 'destroy_world_admin'

  get     'account_activation/:id/edit', to: 'account_activations#edit', as: 'account_activation'
  resources :password_resets,     only: [:new, :create, :edit, :update]
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end