Rails.application.routes.draw do
  devise_for :users

  resources :links
  get :my_links, to: "links#my_links"
  resources :views, path: :v, only: :show

  root 'links#index'
end
