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

    def full_params
      ActionController::Parameters.new(JSON.parse(request.raw_post))
    end

    def clean_headers
      request.headers.reject{ |k,v| k.include?('.') }.to_h
    end
  end
end
