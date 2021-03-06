require 'blackhawk_api/client/entities/product_details'
require 'blackhawk_api/client/entities/product_summary'

module BlackhawkApi
  module Responses
    # Response object for product details
    class ProductDetailsResponse < BaseResponse
      attr_reader :details, :summary

      def initialize(http_response)
        super(http_response.code, http_response.headers, http_response.raw_body)
      end

      protected

      def parse(object)
        @summary = ProductSummary.new(object.summary)
        @details = ProductDetails.new(object.details)
      end
    end
  end
end
