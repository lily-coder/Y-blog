
Rails.application.routes.draw do
  get '/posts/', to: 'posts#index'
  get '/posts/', to: 'posts#show'
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show]
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
