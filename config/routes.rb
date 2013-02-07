Portfolio2k13::Application.routes.draw do
  devise_for :users

  resources :projects

  root :to => 'pages#index'
end
