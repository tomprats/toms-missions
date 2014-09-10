Rails.application.routes.draw do
  root "missionaries#index"

  get :sign_in, to: "sessions#new"
  post :sign_in, to: "sessions#create"
  delete :sign_out, to: "sessions#destroy"

  get :missionaries, to: "missionaries#index"
  post :missionaries, to: "missionaries#create"

  get :me, to: "missionaries#show"
  put :me, to: "missionaries#update"
  get "me/edit", to: "missionaries#edit", as: :edit_me

  get "m/:username", to: "missionaries#show", as: :missionary
  put "m/:username", to: "missionaries#update"
  get "m/:username/edit", to: "missionaries#edit", as: :edit_missionary
end
