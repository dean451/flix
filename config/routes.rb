Rails.application.routes.draw do
  resources :genres
  resources :favorites
  resource :session

  get "signup" => "users#new"
  resources :users
  root "movies#index"

  get "movies/filter/hits" => "movies#index", scope: "hits"
  get "movies/filter/flops" => "movies#index", scope: "flops"
  get 'movies/filter/:scope' => "movies#index", as: :filtered_movies

  resources :movies do
    resources :reviews
  end
end
