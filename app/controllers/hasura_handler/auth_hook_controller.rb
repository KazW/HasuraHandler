require_dependency "hasura_handler/application_controller"

module HasuraHandler
  class AuthHookController < ApplicationController
    def get_mode
      @headers = clean_headers
      authenticate
    end

    def post_mode
      @headers = JSON.parse(request.raw_post).
        map{ |k,v| [k.to_s.sub('-', '_').upcase, v] }.
        to_h

      authenticate
    end

    private

    def authenticate
      @authenticator = HasuraHandler.authenticator.new(@headers)

      if @authenticator.success?
        render json: @authenticator.response, status: 200
      else
        render json: { error: true, message: @authenticator.error_message }, status: 401
      end
    end
  end
end
