require 'blackhawk_api/client/dto/product_line_details'

module BlackhawkApi
  # Response object for product line details.
  class ProductLineDetailsResponse < BaseResponse
    attr_reader :details, :summary

    def initialize(http_response)
      super(http_response.code, http_response.headers, http_response.raw_body)
    end

    protected

    def parse(object)
      @details = ProductLineDetails.new(object.details)
      @summary = ProductLineSummary.new(object.summary)
    end
  end
end
