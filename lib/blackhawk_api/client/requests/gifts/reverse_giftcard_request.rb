require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  module Requests
    # Request object to reverse an egift for a given request id.
    # For the instances of system timeouts or exceptions when your application calls a Blackhawk
    # Digital Service, you can reverse generateEGift or voidEGift transactions.
    class ReverseGiftCardRequest < Request
      attr_reader :reversal_egift_request_id

      # Creates a new request object.
      def initialize(original_request_id)
        @reversal_egift_request_id = original_request_id
      end

      # Formats the request data in JSON format.
      def to_json
        json_object = {}

        json_object[:reversalEGiftRequestId] = @reversal_egift_request_id

        JSON.generate(json_object)
      end
    end
  end
end