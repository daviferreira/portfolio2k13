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
  match '(/:locale)/projects/:id' => "projects#show", :as => :localized_project, :via => :get
  root :to => 'pages#index'
end
