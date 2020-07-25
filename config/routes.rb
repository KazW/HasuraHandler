HasuraHandler::Engine.routes.draw do
  if HasuraHandler.events_enabled
    post '/events', to: 'events#process'
  end

  if HasuraHandler.actions_enabled
    post '/actions', to: 'actions#process'
  end
end
