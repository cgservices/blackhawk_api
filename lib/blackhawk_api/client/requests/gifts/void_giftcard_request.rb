require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  module Requests
    # Request object to void an egift.
    # You void a generateEGift operation in cases where a consumer returns an
    # eGift or when an eGift is being used fraudulently.
    class VoidGiftCardRequest < Request
      attr_reader :egift_id, :retrieval_reference_number, :correlation_id

      # Creates a new request object.
      def initialize(egift_id, retrieval_reference_number, correlation_id = nil)
        @egift_id = egift_id
        @retrieval_reference_number = retrieval_reference_number
        @correlation_id = correlation_id unless correlation_id.nil?
      end

      # Formats the request data in JSON format.
      def to_json
        json_object = {}

        json_object[:eGiftId] = @egift_id
        json_object[:retrievalReferenceNumber] = @retrieval_reference_number
        json_object[:correlationId] = @correlation_id unless @correlation_id.nil?

        JSON.generate(json_object)
      end
    end
  end
end
