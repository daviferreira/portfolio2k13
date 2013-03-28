Portfolio2k13::Application.routes.draw do
  devise_for :users

  resources :categories
  resources :photos
  resources :posts
  resources :projects

  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  match '/:locale' => 'pages#index',
                      :constraints => {:locale => /en/},
                      :as => :localized_root

  scope "(:locale)", :locale => /en/, :via => :get do
    match '/projects/:id' => "projects#show", :as => :localized_project
    match '/categories/:id' => "categories#show", :as => :localized_category
    # TODO
    # projects archive
    # tags
    # blog
    # post
    # blog archive
    # blog tags/categories
  end

  root :to => 'pages#index'
end
