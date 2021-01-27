Rails.application.routes.draw do
  devise_for :users, :controllers => {
                       :omniauth_callbacks => "users/omniauth_callbacks",
                       :sessions => "users/sessions",
                       :registrations => "users/registrations",
                     }

  root "pages#home"

  resources :queries, only: [] do
    collection do
      get :list
      get :list, to: "queries#listpost"
      get :volume
      post :volume, to: "queries#volumepost"
      get :sentiment
      post :sentiment, to: "queries#sentpost"
      get :topic
      post :topic, to: "queries#topicpost"
      get :wordcloud
      post :wordcloud, to: "queries#cloudpost"
      get :termfreq
      post :termfreq, to: "queries#termfreqpost"
    end
  end

  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
    get "/user" => "queries#list", :as => :user_root
  end
end
