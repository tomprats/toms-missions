Rails.application.routes.draw do
  root "users#index"

  get :login, to: "sessions#new"
  post :login, to: "sessions#create"
  delete :logout, to: "sessions#destroy"

  get :users, to: "users#index"
  post :users, to: "users#create"

  get :me, to: "users#show"
  put :me, to: "users#update"
  get "me/edit", to: "users#edit", as: :edit_me
  post :upload_profile_picture, to: "users#upload_profile_picture"

  get "m/:username", to: "users#show", as: :user
  put "m/:username", to: "users#update"
  get "m/:username/edit", to: "users#edit", as: :edit_user
end
