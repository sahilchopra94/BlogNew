Rails.application.routes.draw do
  get 'errors/not_found'
    get 'errors/internal_server_error'
# get '/index', to: 'articles#index'
# get '/login' to: "devise/sessions#new"
# get '/register' to: "devise/registrations#new"
get '/dashboard', to: 'articles#dashboard'
get '/social', to: 'articles#social'
get '/form_element', to:'articles#form_element'
get '/form_layout', to:'articles#form_layout'
get '/form_wizard', to:'articles#form_wizard'


 match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all


devise_for :users, :controllers => { sessions: 'users/sessions', :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :users do 
  	get 'login', to: 'devise/sessions#new', :path => 'users'
  end
  
resources :members
  resources :articles do
  resources :comments
end
 	root to: 'articles#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
