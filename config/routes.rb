Rails.application.routes.draw do
  root 'sessions#index'
  resource :session, only: [:index, :destroy]
  get '/auth/:provider/callback' => 'sessions#create'
end
