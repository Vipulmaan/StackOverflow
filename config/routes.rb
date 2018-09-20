Rails.application.routes.draw do

  concern :commentable do
    resources :comments
  end

  concern :taggable do
    resources :tags
  end

  resources :users do
    resources :tags , concerns: :taggable
    resources :questions, concerns: :commentable do
      resources :answers, concerns: :commentable
      resources :tags ,concerns: :taggable
     end
    resources :answers, only: [:index, :edit, :destroy, :show, :update], concerns: :commentable
    resources :comments, only: [:index, :edit, :destroy, :show, :update]
  end


end

