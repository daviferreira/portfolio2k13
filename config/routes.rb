Portfolio2k13::Application.routes.draw do

  get 'open_source_projects/index'

  scope '(:locale)', :locale => /en/, :via => :get do
    match '/' => 'pages#index', :as => :localized_root
    match '/open-source' => 'open_source_projects#index', :as => :open_source
    match '/posts(.:format)' => 'posts#index', :as => :posts
    match '/posts/:id(.:format)' => 'posts#show', :as => :post
    match '/projects(.:format)' => 'projects#index', :as => :projects
    match '/projects/by-category/:category_id(.:format)' => 'projects#index', :as => :projects_by_category
    match '/projects/search' => 'projects#index', :as => :projects_search
    match '/projects/:id(.:format)' => 'projects#show', :as => :project
    match '/page/:id(.:format)' => 'pages#show', :as => :page
  end

  namespace :admin do
    root :to => 'projects#index'
    resources :categories, :photos, :posts, :projects, :pages,
              :open_source_projects, :only => [:new, :create, :edit, :update, :destroy, :index]
  end

  scope '/admin' do
    devise_for :users
  end

  match '/blog', :to => redirect('/posts')
  match '/en/blog', :to => redirect('/en/posts')

  root :to => 'pages#index'
end
