module BlackhawkApi
  class ProductLineSummary
    attr_reader :entity_url, :brand_name, :brand_logo_image, :product_line_name,
      :brand_id, :product_line_status, :account_type, :payment_network_type,
      :start_date, :end_date, :locale
    
    def initialize(summary)
      @entity_url = summary.entityId
      @brand_name = summary.brandName
      @brand_logo_image = summary.brandLogoImage
      @product_line_name = summary.productLineName
      @brand_id = summary.brandId
      @product_line_status = summary.productLineStatus
      @account_type = summary.accountType
      @payment_network_type = summary.paymentNetworkType
      @start_date = summary.startDate
      @end_date = summary.endDate
      @locale = summary.locale
    end
  end
end