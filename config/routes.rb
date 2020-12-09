Rails.application.routes.draw do
  
  root to: 'homes#index'

  get 'homes/index'
  get 'homes/caution'


  get 'edits', to: 'edits#index'
  
  get 'edits/authentication'
  post 'edits/authentication'

  get 'edits/caution'

  get 'edits/aupdate', to: 'edits#authentication_update'
  post 'edits/aupdate', to: 'edits#authentication_update'
  patch 'edits/aupdate', to: 'edits#authentication_update'


  get 'statistics', to: 'statistics#index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users
  
end
