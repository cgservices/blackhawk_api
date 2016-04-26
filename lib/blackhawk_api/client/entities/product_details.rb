require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  # Data class for product details
  class ProductDetails
    attr_reader :creator_id, :updater_id, :notes, :created_timestamp, :updated_timestamp,
                :product_description, :default_product_configuration_id, :is_taxable, :search_keywords,
                :activation_characteristics, :reload_characteristics, :fulfillment_characteristics,
                :product_fees, :redemption_characteristics, :terms_and_conditions, :product_configurations

    # Initializes a new product details instance
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def initialize(details)
      @creator_id = details.creatorId
      @updater_id = details.updaterId
      @notes = details.notes
      @created_timestamp = details.createdTimestamp
      @updated_timestamp = details.updatedTimestamp
      @product_description = details.productDescription
      @default_product_configuration_id = details.defaultProductConfigurationId
      @is_taxable = details.isTaxable
      @search_keywords = details.searchKeywords
      @activation_characteristics = details.activationCharacteristics
      @reload_characteristics = details.reloadCharacteristics
      @fulfillment_characteristics = details.fulfillmentCharacteristics
      @product_fees = details.productFees
      @redemption_characteristics = details.redemptionCharacteristics
      @terms_and_conditions = details.termsAndConditions
      @product_configurations = details.productConfigurations
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize
  end
end
