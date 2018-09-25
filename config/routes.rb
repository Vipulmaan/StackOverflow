Rails.application.routes.draw do


  get 'sessions/login'
  get 'sessions/home'
  get 'sessions/profile'
  root 'sessions#index'
  post'/login' , to:  "sessions#create"
  get "/logout", to: "sessions#logout"
  post "/favorite", to: "favorite_questions#create"
  delete "/unfavorite", to: "favorite_questions#destroy"
  get "/all_users", to: "users#all_users"
  get '/all_questions', to: 'questions#index'

  root to:  "sessions#login"
  get  "/signup", to: "users#new"
  get "/login", :to => "sessions#login"


  concern :commentable do
    resources :comments
  end

  concern :taggable do
    resources :tags
  end

  concern :votable do
    resources :votes
  end

  resources :users do
    resources :profile
    resources :tags , concerns: :taggable
    resources :questions, concerns: :commentable do
      resources :answers, concerns: :commentable
      resources :answers, concerns: :votable
      resources :tags ,concerns: :taggable
    end
    resources :questions, concerns: :votable


    resources :answers, only: [:index, :edit, :destroy, :show, :update], concerns: :commentable
    resources :comments, only: [:index, :edit, :destroy, :show, :update]
  end

  get '*path', to: 'profile#404'

end