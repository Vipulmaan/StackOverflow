Rails.application.routes.draw do



  get 'sessions/login'
  get 'sessions/home'
  get 'sessions/profile'
  root 'index#index'
  post'/loginattempt' , to:  "sessions#login_attempt"
  get "/logout", to: "sessions#logout"


  root to:  "sessions#login"
  get  "/signup", to: "users#new"
  get "/login", :to => "sessions#login"
  get "/home", :to => "sessions#home"
  get "/profile", :to => "sessions#profile"
  get "/setting", :to => "sessions#setting"


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


end