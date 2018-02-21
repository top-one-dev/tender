Rails.application.routes.draw do

  resources :qanswers
  resources :ianswers
  resources :messages
  resources :folders
  resources :notifications
  resources :questions
  resources :items
  resources :requests
  resources :suppliers
  resources :companies

  get 'dashboard/request', to: 'dashboard#trequest', as: 'dashboard_request'

  get 'dashboard/requisition'

  get 'dashboard/supplier'

  get 'dashboard/activity'

  get 'dashboard/message'

  get 'dashboard/report'

  devise_for :users

  get 'static/home'
  get '/privacy-policy', to: 'static#privacy_policy', as: 'privacy_policy'
  get '/terms-of-use', to: 'static#terms_of_use', as: 'terms_of_use'

  root 'static#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
