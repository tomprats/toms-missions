Rails.application.routes.draw do
  root "trips#index"

  get :login, to: "sessions#new"
  post :login, to: "sessions#create"
  delete :logout, to: "sessions#destroy"
  resources :tokens, only: [:create, :show], param: :uid

  get :missionaries, to: "users#index", as: :users
  post :missionaries, to: "users#create"

  get :me, to: "users#show"
  put :me, to: "users#update"
  get "me/edit", to: "users#edit", as: :edit_me

  get "m/:username", to: "users#show", as: :user
  put "m/:username", to: "users#update"
  get "m/:username/edit", to: "users#edit", as: :edit_user
  post "m/:username/image", to: "users#upload_image", as: :upload_user_image

  resources :trips, param: :uid
  get "trips/:uid/users", to: "trips#users", as: :trip_users
  post "trips/:uid/users", to: "trips#update_users"

  get "m/:username/missions", to: "missions#index", as: :missions
  get "m/:username/m/:trip_uid", to: "missions#show", as: :mission

  get "m/:username/m/:trip_uid/images", to: "missions#images", as: :mission_images
  post "m/:username/m/:trip_uid/images", to: "missions#add_images"
  delete "m/:username/m/:trip_uid/images/:id", to: "missions#delete_image", as: :delete_mission_image

  resources :images, only: :show
  resources :resources

  get "f/:username", to: "favorites#index", as: :favorites
  post "f/:image_id", to: "favorites#toggle", as: :favorite
end
