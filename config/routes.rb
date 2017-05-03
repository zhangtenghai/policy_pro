Rails.application.routes.draw do
  devise_for :admins
  resources :users do
    collection do
      get 'success'
      get 'export'
    end 
   
  end
  root "users#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
