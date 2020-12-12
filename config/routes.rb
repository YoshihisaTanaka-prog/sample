Rails.application.routes.draw do
  
  root to: 'homes#index'

  get 'homes/index'
  get 'homes/show'
  get 'homes/constructing'
  get 'homes/caution'


  get 'edits', to: 'edits#index'
  
  get 'edits/authentication'
  post 'edits/authentication'

  get 'edits/caution'

  get 'edits/aupdate', to: 'edits#authentication_update'
  post 'edits/aupdate', to: 'edits#authentication_update'
  patch 'edits/aupdate', to: 'edits#authentication_update'

  get 'edits/add', to: 'edits#add_route'
  post 'edits/add', to: 'edits#add_route'
  get 'edits/create_route'
  post 'edits/create_route'
  get 'edits/edit'
  post 'edits/edit_update'
  get 'edits/edit_update'
  post 'edits/edit'
  get 'edits/show'
  post 'edits/show'


  get 'statistics', to: 'statistics#index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users
  
end
