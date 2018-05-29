Rails.application.routes.draw do
  root :to => 'review_test#index'

  devise_for :users, controllers: {
      registrations: "users/registrations",
      omniauth_callbacks: "users/omniauth_callbacks"
  }
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :citicizes do
    collection do
      post :confirm
    end
    resources :comments
  end
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  post 'estimates/:id', to: 'estimates#new'
  resources :estimates, only: [:create, :destroy]


end
