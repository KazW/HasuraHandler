require_dependency 'hasura_handler/application_controller'

module HasuraHandler
  class ActionsController < ApplicationController
    before_action :check_header

    def index
      unless HasuraHandler::Action.hasura_actions.keys.include?(action_params['action']['name'])
        render json: { error: true, message: 'action name not registered' }, status: 404
        return
      end

      klass = HasuraHandler::Action.hasura_actions[action_params['action']['name']]
      action = klass.new(
        request.headers.reject{ |k,v| k.include?('.') }.to_h,
        action_params['session_variables'].to_h,
        action_params['input'].to_h
      )

      action.run
      if action.error_message.present?
        render json: { error: true, message: action.error_message }, status: 400
      else
        render json: action.output
      end
    end

    def action_params
      full_params.permit(
        action: [:name],
        input: {},
        session_variables: {}
      )
    end
  end
end
