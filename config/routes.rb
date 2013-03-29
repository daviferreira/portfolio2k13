Portfolio2k13::Application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  scope "(:locale)", :locale => /en/, :via => :get do
    match '/' => 'pages#index', :as => :localized_root
    match '/projects.html' => "pages#projects", :as => :localized_projects
    match '/blog(/index.html)' => "pages#blog", :as => :localized_blog
    match '/projects/:id' => "projects#show", :as => :localized_project
    # TODO
    # projects archive
    # tags
    # blog
    # post
    # blog archive
    # blog tags/categories
  end

  resources :categories
  resources :photos
  resources :posts
  resources :projects

  root :to => 'pages#index'
end
