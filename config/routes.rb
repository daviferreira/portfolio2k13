Portfolio2k13::Application.routes.draw do
  devise_for :users

  resources :projects
  resources :categories
  resources :photos

  devise_scope :user do
      get "/login" => "devise/sessions#new"
  end

  root :to => 'pages#index'
end
