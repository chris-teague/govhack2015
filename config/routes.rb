Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'

  resources :postcodes, only: [:show], path: 'suburbs'
  resources :electorates, only: [:show] do
    resources :data_sets, only: [:show]
  end

  get "/electorates/:id/vs/:comparison_id", to: 'electorates#compare'

  resources :search do
    collection do
      get :locations
      post :relocate
    end
  end

end
