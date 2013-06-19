Portfolio2k13::Application.routes.draw do

  scope "(:locale)", :locale => /en/, :via => :get do
    #resources :categories, :pages, :posts, :projects
    match '/' => 'pages#index', :as => :localized_root
    match '/categories/:id(.:format)' => "categories#show", :as => :category
    match '/posts(.:format)' => "posts#index", :as => :posts
    match '/posts/:id(.:format)' => "posts#show", :as => :post
    match '/projects(.:format)' => "projects#index", :as => :projects
    match '/projects/:id(.:format)' => "projects#show", :as => :project
  end

  namespace :admin do
    root :to => "projects#index"
    resources :categories, :photos, :posts, :projects, :pages,
              :open_source_projects
  end

  scope '/admin' do
    devise_for :users
  end

  root :to => 'pages#index'
end
