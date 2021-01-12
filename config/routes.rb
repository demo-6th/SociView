Rails.application.routes.draw do
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks",
    :sessions => "users/sessions",  
    :registrations => "users/registrations"}

  root 'pages#home'
  

  resources :queries, only: [:index] do 
    collection do
      get :list
      get :volume
      get :sentiment
      post :sentiment, to: 'queries#sentpost'
      get :topic
      post :topic ,to: 'queries#topicpost' 
      get :wordcloud
      post :wordcloud, to: 'queries#cloudpost'
      get :diffusion
    end
  end

  devise_scope :user do
    get '/users/sign_out' => "devise/sessions#destroy"
    get '/user' => "queries#index", :as => :user_root
  end
end
