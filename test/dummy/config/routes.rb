Rails.application.routes.draw do
  mount HasuraHandler::Engine => '/hasura_handler'
end
