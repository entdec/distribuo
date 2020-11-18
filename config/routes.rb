Mobilis::Engine.routes.draw do
  get '/apps', to: 'apps#show'
  get '/apps/manifest', to: 'apps#manifest'
end
