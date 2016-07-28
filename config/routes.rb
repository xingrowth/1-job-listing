Rails.application.routes.draw do
  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
    end
  end

  devise_for :users
  resources :jobs
  root 'jobs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
