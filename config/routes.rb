Portfolio2k13::Application.routes.draw do
  devise_for :users

  resources :categories
  resources :photos
  resources :posts
  resources :projects

  devise_scope :user do
    get "/login" => "devise/sessions#new"
  end

  match '/:locale' => 'pages#index'
  # TODO: use scope
  match '(/:locale)/projects/:id' => "projects#show", :as => :localized_project,
                                                      :via => :get,
                                                      :constraints => {:locale => /en/}
  match '(/:locale)/categories/:id' => "categories#show", :as => :localized_category,
                                                      :via => :get,
                                                      :constraints => {:locale => /en/}
  root :to => 'pages#index'
end
