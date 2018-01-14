Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :lists, except: [:index, :destroy] do
    resources :items
    namespace :items do
      delete 'soft_delete/:id', to: 'soft_delete#destroy'
      put 'recover/:id', to: 'recover#update'
    end
  end

  resources :list_items, only: [:index, :destroy]
  namespace :list_items do
    delete '/soft_delete/:id', to: 'soft_delete#destroy'
    put '/recover/:id', to: 'recover#update'
    get '/thrash', to: 'thrash#index'
  end

  root to: 'list_items#index'
end
