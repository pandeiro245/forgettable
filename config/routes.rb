Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'users#login'
end
