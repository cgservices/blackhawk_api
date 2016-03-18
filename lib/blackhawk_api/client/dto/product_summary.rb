require 'blackhawk_api/client/requests/blackhawk_identity'

module BlackhawkApi
  class ProductSummary
    attr_reader :entity_url, :product_name, :currency, :universal_product_code,
      :product_line_id, :start_date, :end_date, :locale
      
    def initialize(summary)
      @entity_url = summary.entityId
      @product_name = summary.productName
      @currency = summary.currency
      @universal_product_code = summary.universalProductCode
      @product_line_id = BlackhawkIdentity.new(summary.product_line_id)
      @start_date = summary.startDate
      @end_date = summary.endDate
      @locale = summary.locale
    end
  end
end