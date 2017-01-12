Rails.application.routes.draw do
  root to: 'monitor#index'
  get '/admin', to: 'admin#index'
end
