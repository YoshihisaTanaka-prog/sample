Rails.application.routes.draw do
  
  root to: 'homes#index'

  get 'homes/index'
  get 'homes/caution'
  get 'homes/authentication'

  get 'edits', to: 'edits#index'
  
  get 'edits/authentication'
  post 'edits/authentication'

  get 'edits/caution'

  get 'edits/aupdate', to: 'edits#/authentication_update'
  patch 'edits/aupdate', to: 'edits#/authentication_update'

  devise_for :users
  
end
