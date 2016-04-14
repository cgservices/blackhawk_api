require 'pry'

module BlackhawkApi
  # Response object for account locations
  class AccountLocationResponse < BaseResponse
    attr_reader :account_url

    def initialize(http_response)
      super(http_response.code, http_response.headers, http_response.raw_body)
    end

    protected

    def parse(object)
      # TODO: Check url
      binding.pry
      @account_url = object
    end
  end
end
