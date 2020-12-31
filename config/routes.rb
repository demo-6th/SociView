Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'

  resources :querys
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
