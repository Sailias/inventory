Inventory::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'items#index'

  resources :categories
  resources :items do
    member do
      post :post_to_ebay
    end

    resources :pictures
  end
end
