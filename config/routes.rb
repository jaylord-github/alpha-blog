Rails.application.routes.draw do
  root "pages#home"

  get "about" => "pages#about"

  resources :articles, only: [:show]
end
