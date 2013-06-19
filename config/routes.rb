Portfolio2k13::Application.routes.draw do

  scope "(:locale)", :locale => /en/, :via => :get do
    match '/' => 'pages#index', :as => :localized_root
    match '/projects.html' => "pages#projects", :as => :localized_projects
    # TODO: redirect index.html? => /blog
    match '/blog(/index.html)' => "pages#blog", :as => :localized_blog
    match '/projects/:id' => "projects#show", :as => :localized_project
    match '/posts/:id' => "posts#show", :as => :localized_post
    match '/categories/:id' => "categories#show", :as => :localized_category
    # TODO
    # tags
    # post
    # blog archive
    # blog tags/categories
  end

  namespace :admin do
    root :to => "projects#index"
    resources :categories, :photos, :posts, :projects
  end

  scope '/admin' do
    devise_for :users
  end

#  devise_scope :user do
#    get "/login" => "devise/sessions#new"
#  end



  # TODO: redirect index.html? => /
  root :to => 'pages#index'
end
