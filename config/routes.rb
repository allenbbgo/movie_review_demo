Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users

  get :search, controller: :movies

  resources :movies do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    member do 
      delete 'review_d'
    end
    collection do
      get :autocomplete
    end
    resources :reviews , except: [:show,:index] do
    end
  end
  root 'movies#index'

end
