Rails.application.routes.draw do

  concern :commentable do
    resources :comments
  end

  resources :users do
    resources :questions, concerns: :commentable do
      resources :answers, concerns: :commentable
     end
    resources :answers, only: [:index, :edit, :destroy, :show, :update], concerns: :commentable
    resources :comments, only: [:index, :edit, :destroy, :show, :update]
  end


end

