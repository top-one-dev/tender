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
  get   'request/:id/status/:status', to: 'requests#change_status',   as: 'change_status'
  post  'assign/request',             to: 'requests#assign_request',  as: 'assign_request'
  get   'request/:id/bids',           to: 'requests#compare_bids',    as: 'compare_bids'
  post  'request/set/winner',         to: 'requests#set_winner',       as: 'set_winner'
  
  resources :suppliers
  get   'request/:id/view/:token',    to: 'suppliers#view_request',   as: 'view_request'
  
  resources :companies
  post 'company/invite',                to: 'companies#invite_colleague',       as: 'invite_colleague'
  get  'accept/:user/invite/:company',  to: 'companies#accept_colleage_invite', as: 'accept_invite'
  post 'assign/requisition',            to: 'companies#assign_colleague',       as: 'assign_colleague'

  get 'dashboard/request', to: 'dashboard#trequest', as: 'dashboard_request'

  get 'dashboard/requisition'

  get 'dashboard/supplier'

  get 'dashboard/activity'

  get 'dashboard/message'

  get 'dashboard/report'

  devise_for :users

  get '/home',            to: 'static#home',            as: 'home'  
  get '/privacy-policy',  to: 'static#privacy_policy',  as: 'privacy_policy'
  get '/terms-of-use',    to: 'static#terms_of_use',    as: 'terms_of_use'

  root 'static#landing_page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
