require 'blackhawk_api/client/entities/product_catalog_summary'

module BlackhawkApi
  module Responses
    # Response object with multiple catalog summaries
    class ProductCatalogsResponse < BaseResponse
      attr_reader :total, :results

      def initialize(http_response)
        super(http_response.code, http_response.headers, http_response.raw_body)
      end

      protected

      def parse(object)
        @total = object.total
        @results = object.results.map { |v| ProductCatalogSummary.new(v) }
      end
    end
  end
end