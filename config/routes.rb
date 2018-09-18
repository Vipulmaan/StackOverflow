Rails.application.routes.draw do
   resources :users do
     resources :questions do
     resources :answers , shallow: true
     end
     end
end
