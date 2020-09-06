module HasuraHandler
  class ApplicationController < ActionController::API
    def protect_against_forgery?
      false
    end

    private

    def check_header
      unless request.headers[HasuraHandler.auth_header] == HasuraHandler.auth_key
        render json: { error: true, message: 'unable to authenticate request' }, status: 401
      end
    end

    def raw_params
      @raw_params ||= JSON.parse(request.raw_post)
    end

    def clean_headers
      request.
      headers.
      reject{ |k,v| k.include?('.') }.
      to_h.
      select{ |k,v| k =~ /\AHTTP_/ }.
      to_h
    end
  end
end
