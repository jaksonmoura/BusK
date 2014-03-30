BusK::Application.routes.draw do
  devise_for :users
  get "/sobre" => 'application#about', as: :about
  resources :busstops

  get '/linhas' => 'lines#all_lines', as: :all_lines
  resources :lines do
    resources :returns
    resources :goings
  end
  match 'search' => 'searches#index', as: :search, via: [:get, :post]
  get '/lines/:id/routes' => 'lines#routes', as: :routes

  root :to => 'welcomes#index'
end
