Rails.application.routes.draw do

  resources :agencies

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show] do
    resources :searches do
      resources :announces do
        get 'visited_mail'
      end
      get 'mail_agency'
      get 'define_mail_agency'
    end
  end

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
