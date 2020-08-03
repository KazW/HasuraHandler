module HasuraHandler
  class Authenticator
    attr_accessor :response,
                  :error_message

    def initialize(headers)
      @headers = headers
      @response = {}
    end

    def success?
      begin
        authenticate
      ensure
        return false if @response.blank?
      end

      @response.present? || @error_message.blank?
    end
  end
end
