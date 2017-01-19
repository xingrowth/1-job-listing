Rails.application.routes.draw do
namespace :admin do
  resources :jobs do
    member do
      post :publish
      post :hide
    end
  end
  resources :jobs
end

  devise_for :users
  resources :jobs
  root 'jobs#index'
end
