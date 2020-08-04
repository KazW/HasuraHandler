require_dependency "hasura_handler/application_controller"

module HasuraHandler
  class AuthHookController < ApplicationController
    def get_mode
      @headers = clean_headers.to_h.select{ |k,v| k =~ /\AHTTP_/ }.to_h
      authenticate
    end

    def post_mode
      @headers = raw_params['headers'].
        to_h.
        map{ |k,v| ['HTTP_' + k.to_s.gsub('-', '_').upcase, v] }.
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
