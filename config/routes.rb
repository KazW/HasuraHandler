HasuraHandler::Engine.routes.draw do
  if HasuraHandler.authentication_enabled
    get '/auth', to: 'auth_hook#get_mode'
    post '/auth', to: 'auth_hook#post_mode'
  end

  if HasuraHandler.events_enabled
    post '/events', to: 'events#index'
  end

  if HasuraHandler.actions_enabled
    post '/actions', to: 'actions#index'
  end
end
