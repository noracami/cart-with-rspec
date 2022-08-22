Rails.application.routes.draw do
  get 'carts/show'
  resources :products do
    member do
      post :add_to_cart
    end
  end
  resource :cart, only: [:show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
