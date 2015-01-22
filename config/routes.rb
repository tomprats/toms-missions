Rails.application.routes.draw do
  root "users#index"

  get :sign_in, to: "sessions#new"
  post :sign_in, to: "sessions#create"
  delete :sign_out, to: "sessions#destroy"

  get :users, to: "users#index"
  post :users, to: "users#create"

  get :me, to: "users#show"
  put :me, to: "users#update"
  get "me/edit", to: "users#edit", as: :edit_me
  post :upload_profile, to: "users#upload_profile"

  get "m/:username", to: "users#show", as: :user
  put "m/:username", to: "users#update"
  get "m/:username/edit", to: "users#edit", as: :edit_user
end
