Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'

  resources :queries, only: [:index] do 
    collection do
      get :list
      get :volume
      get :sentiment, to: 'queries#index'
      post :sentiment
      get :topic
      get :wordcloud, to: 'queries#index'
      post :wordcloud
      get :diffusion
    end
  end


  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
