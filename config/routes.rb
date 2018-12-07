Rails.application.routes.draw do

  resources :agencies
  get 'redirect', to: 'pages#redirect'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations" }
  resources :users, only: [:show]
  resources :searches do
    resources :announces do
      get 'visited_mail'
    end
    get 'mail_agency'
    get 'define_mail_agency'
  end

  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
