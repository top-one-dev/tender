Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :categories
  resources :stockholders
  resources :requisitions
  resources :bids
  get   'bid/:id/pdf',              to: 'bids#pdf',                 as: 'bid_pdf'
  resources :qanswers
  resources :ianswers
  resources :messages
  resources :folders
  resources :notifications
  resources :questions
  resources :items
  resources :requests
  post  'assign/request',             to: 'requests#assign_request',  as: 'assign_request'
  post  'request/preview',            to: 'requests#preview_request', as: 'preview_request'      
  get   'request/:id/bids',           to: 'requests#compare_bids',    as: 'compare_bids'
  post  'request/set/winner',         to: 'requests#set_winner',      as: 'set_winner'
  get   'request/:id/export',         to: 'requests#export_excel',    as: 'export_excel'
  get   'request/:id/report',         to: 'requests#pdf',             as: 'open_report'
  get   'request/:id/download',       to: 'requests#download',        as: 'download'
  post  'request/delete/document',    to: 'requests#delete_document', as: 'delete_document'
  get   'request/:id/status/:status', to: 'requests#change_status',   as: 'change_status'
  post  'request/preview/invitation', to: 'requests#preview_invite',  as: 'preview_invitation'
  post  'request/:id/invite',         to: 'requests#invite_supplier', as: 'invite_supplier'
  
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

  # get '/home',            to: 'static#home',            as: 'home'  
  get '/privacy-policy',  to: 'static#privacy_policy',  as: 'privacy_policy'
  get '/terms-of-use',    to: 'static#terms_of_use',    as: 'terms_of_use'
  get '/contact',         to: 'static#contact',         as: 'contact'
  get '/demo',            to: 'static#demo',            as: 'demo'
  get '/prequalification',to: 'static#prequalification',as: 'prequalification'
  get '/requisition/bid', to: 'static#requisition',     as: 'requisition_bid'
  get '/vendor',          to: 'static#vendor',          as: 'vendor'
  get '/diligence',       to: 'static#diligence',       as: 'diligence'
  get '/about',		      to: 'static#company',         as: 'about'


  root 'static#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
