require 'blackhawk_api/client/entities/gift_details'

module BlackhawkApi
  module Responses
    # Response object for gift details.
    class GiftDetailsResponse < BaseResponse
      attr_reader :information
      attr_reader :request_id

      def initialize(http_response, request_id = nil)
        super(http_response.code, http_response.headers, http_response.raw_body)
        @request_id = request_id
      end

      protected

      def parse(object)
        @information = GiftDetails.new(object)
      end
    end
  end
end