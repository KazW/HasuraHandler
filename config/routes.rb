HasuraHandler::Engine.routes.draw do
  if HasuraHandler.events_enabled
    post '/events', to: 'events#index'
  end

  if HasuraHandler.actions_enabled
    post '/actions', to: 'actions#index'
  end
end
