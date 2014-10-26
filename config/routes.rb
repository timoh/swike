Rails.application.routes.draw do
  get 'timeline/index'
  get 'timeline/pop'

  resources :users

  get '/tweets', to: 'home#tweets_to_json'
  get '/', to: 'home#index'
  root to: 'home#index'
get  'auth/:provider/callback' => 'sessions#create',:as => 'login'
get 'auth/:provider', to: 'sessions#create'
get 'auth/failure', to: redirect('/')
get 'signout', to: 'sessions#destroy', as: 'signout'
end
