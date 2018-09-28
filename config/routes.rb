Rails.application.routes.draw do


  get 'sessions/login'
  get 'sessions/home'
  get 'sessions/profile'
  root 'sessions#index'
  post'/login' , to:  "sessions#create"
  get "/logout", to: "sessions#logout"
  post "/favorite", to: "favorite_questions#create"
  delete "/unfavorite", to: "favorite_questions#destroy"
  get '/all_questions', to: 'questions#index'

  root to:  "sessions#login"
  get  "/signup", to: "users#new"
  get "/login", :to => "sessions#login"
  get "/home", :to => "sessions#home"
  get "/setting", :to => "sessions#setting"

  get "/users/:user_id/questions/:id/answers/:answer_id/valid_answer" , :to => "questions#valid_answer" ,:as => "valid_answer"
  # get '/404', to: 'errors#not_found'
  # get '/500', to: 'errors#internal_server_error'


  # concern :commentable do
  #   resources :comments
  # end
  #
  # concern :taggable do
  #   resources :tags
  # end
  #
  # concern :votable do
  #   resources :votes
  # end
  #
  # resources :users do
  #   resources :tags , concerns: :taggable
  #   resources :questions, concerns: :commentable do
  #     resources :answers, concerns: :commentable
  #     resources :answers, concerns: :votable
  #     resources :tags ,concerns: :taggable
  #   end
  #   resources :questions, concerns: :votable
  #
  #
  #   resources :answers, only: [:index, :edit, :destroy, :show, :update], concerns: :commentable
  #   resources :comments, only: [:index, :edit, :destroy, :show, :update]
  # end
  #

  resources :users do
    resources :tags
    resources :questions do
      resources :answers, except: [:new] do
        resources :comments, except: [:new]
        resources :votes, only: [:index, :create]
      end
      resources :comments, except: [:new]
      resources :tags
      resources :votes, only: [:index, :create]
    end
  end
  get '*path', to: 'errors#route_not_found'

end