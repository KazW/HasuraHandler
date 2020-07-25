module HasuraHandler
  class ApplicationController < ActionController::API
    before_action :check_header

    private

    def check_header
      unless request.headers[HasuraHandler.auth_header] == HasuraHandler.auth_key
        render json: { error: true, message: 'unable to authenticate request' }, status: 401
      end
    end
  end
end
