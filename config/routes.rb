Rails.application.routes.draw do
  resources :searches do
    resources :announces
    get 'mail_agency'
    get 'define_mail_agency'
  end
  resources :agencies

  devise_for :users
  resources :users, only: [:show]

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
