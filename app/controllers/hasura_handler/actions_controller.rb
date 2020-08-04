require_dependency 'hasura_handler/application_controller'

module HasuraHandler
  class ActionsController < ApplicationController
    before_action :check_header

    def index
      unless HasuraHandler::Action.hasura_actions.keys.include?(raw_params['action']['name'])
        render json: { error: true, message: 'action name not registered' }, status: 404
        return
      end

      klass = HasuraHandler::Action.hasura_actions[raw_params['action']['name']]
      action = klass.new(
        clean_headers,
        raw_params['session_variables'].to_h,
        raw_params['input'].to_h
      )

      action.run
      if action.error_message.present?
        render json: { error: true, message: action.error_message }, status: 400
      else
        render json: action.output
      end
    end
  end
end
