require 'blackhawk_api/client/dto/account_information'

module BlackhawkApi
  # Response after the Create Account call.
  class AccountCreatedResponse < BaseResponse
    attr_reader :information

    def initialize(http_response)
      super(http_response.code, http_response.headers, http_response.raw_body)
    end

    protected

    def parse(object)
      @information = AccountInformation.new(object)
    end
  end
end
