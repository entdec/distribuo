Mobilis::Engine.routes.draw do
  resources :apps do
    resources :releases, controller: 'apps/releases' do
      get 'download', action: :download
      get 'manifest', action: :manifest
    end
  end

  namespace :admin do
    resources :apps do
      resources :releases, controller: 'apps/releases'
    end
  end

  get '/', to: 'apps#index'
  get '/:id', to: 'apps#show'
end
