Rails.application.routes.draw do

  resources :stockholders
  resources :requisitions
  resources :bids
  resources :qanswers
  resources :ianswers
  resources :messages
  resources :folders
  resources :notifications
  resources :questions
  resources :items
  resources :requests
  resources :suppliers
  get 'request/:id/view/:token', to: 'suppliers#view_request', as: 'view_request'
  resources :companies
  post 'company/invite', to: 'companies#invite_colleague', as: 'invite_colleague'
  get  'accept/:user/invite/:company', to: 'companies#accept_colleage_invite', as: 'accept_invite'

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
