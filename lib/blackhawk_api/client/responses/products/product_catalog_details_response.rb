require 'blackhawk_api/client/base'
require 'blackhawk_api/client/entities/product_catalog_details'
require 'blackhawk_api/client/entities/product_catalog_summary'

module BlackhawkApi
  module Responses
    # Response object with catalog details
    class ProductCatalogDetailsResponse < BaseResponse
      attr_reader :entity_url, :summary, :details

      def initialize(http_response)
        super(http_response.code, http_response.headers, http_response.raw_body)
      end

      protected

      def parse(object)
        @entity_url = object.entityId
        @summary = ProductCatalogSummary.new(object.summary)
        @details = ProductCatalogDetails.new(object.details)
      end
    end
  end
end