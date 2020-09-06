require_dependency "hasura_handler/application_controller"

module HasuraHandler
  class AuthHookController < ApplicationController
    def get_mode
      @headers = clean_headers
      authenticate
    end

    def post_mode
      @headers = raw_params['headers'].
        to_h.
        map{ |k,v| [standardize_header(k), v] }.
        to_h

      authenticate
    end

    private

    def authenticate
      @authenticator = HasuraHandler.
        authenticator.
        to_s.
        constantize.
        new(@headers)

      if @authenticator.success?
        render json: @authenticator.response, status: 200
      else
        render json: { error: true, message: @authenticator.error_message }, status: 401
      end
    end

    def standardize_header(header)
      "HTTP_#{header.to_s.gsub('-', '_').upcase}"
    end
  end
end
