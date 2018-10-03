Rails.application.routes.draw do


  get 'sessions/login'
  get 'sessions/home'
  get 'sessions/profile'
  root 'sessions#index'
  post '/create' , to: "sessions#create" , :as => "session_create"
  get "/logout", to: "sessions#logout"
  post "/favorite", to: "favorite_questions#create"
  delete "/unfavorite", to: "favorite_questions#destroy"
  get '/all_questions', to: 'questions#index'

  root to:  "sessions#login"
  get  "/signup", to: "users#new"
  get "/login", :to => "sessions#login"
  get "/home", :to => "sessions#home"
  get "/setting", :to => "sessions#setting"
  get '/:name/questions' , :to => "tags#show" , :as => "tag_questions"
  get  'all_tags' , :to => "available_tags#index" 

  get "/users/:user_id/questions/:id/answers/:answer_id/valid_answer" , :to => "questions#valid_answer" ,:as => "valid_answer"
  # get '/404', to: 'errors#not_found'
  # get '/500', to: 'errors#internal_server_error'


  resources :users do
    resources :tags , except: [:show,:edit,:update]
    resources :questions do
      resources :answers, except: [:new] do
        resources :comments, except: [:new]
        resources :votes, only: [:index, :create]
      end
      resources :comments, except: [:new]
      resources :tags , except: [:show,:edit,:update]
      resources :votes, only: [:index, :create]
    end
  end
  get '*path', to: 'errors#route_not_found'

end