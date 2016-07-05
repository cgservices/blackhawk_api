require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  module Requests
    # Request object to find an account.
    class FindAccountRequest < Request
      attr_reader :account_id

      def initialize(account_id)
        @account_id = BlackhawkIdentity.new(account_id)
      end
    end
  end
end
