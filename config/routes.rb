Rails.application.routes.draw do
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new"
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration"
  end
  
  devise_for :users
  
  resources :wikis
  
  get 'welcome/about'

  root 'welcome#index'
end
