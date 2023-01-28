Rails.application.routes.draw do
  resources :posts do 
    collection do
      get "me" # JUST UN EXEMPLE D'ACTION PERMETTANT DE METTRE EN RELIEF LE FONCTIONNEMENT DE "can :manage"(dans le model Ability)
    end
  end
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'home#index'
  get 'home/private'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
