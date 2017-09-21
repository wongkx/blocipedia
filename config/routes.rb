Rails.application.routes.draw do
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new"
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration"
  end
  
  devise_for :users
  
  resources :wikis do
    get '/collaborator' => 'wikis#collaborator'
    post '/add' => 'wikis#add', as: :add
    get '/collaborator_remove' => 'wikis#collaborator_remove'
    delete '/remove' => 'wikis#remove', as: :remove
  end
  
  resources :charges, only: [:new, :create]
  
  resources :users do
    post '/downgrade' => 'users#downgrade', as: :downgrade
  end
  
  get 'welcome/about'
  
  authenticated :user do
    root to: 'wikis#index', as: :authenticated_root
  end

  root 'welcome#index'
end
