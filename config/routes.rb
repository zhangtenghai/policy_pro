Rails.application.routes.draw do
  devise_for :admins, :skip => [:registrations]
  resources :users do
    collection do
      get 'success'
      get 'export'
    end 
   
  end
  root "users#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
