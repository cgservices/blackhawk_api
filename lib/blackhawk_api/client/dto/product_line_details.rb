module BlackhawkApi
  # Data class for product line details
  class ProductLineDetails
    attr_reader :creator_id, :updater_id, :notes, :created_timestamp, :updated_timestamp,
                :product_line_description, :customer_service_phone_number, :customer_service_website,
                :terms_and_conditions, :card_number_label, :default_product_id, :default_currency,
                :bank_identification_numbers, :pin_required, :supported_features, :activation_type,
                :pin_characteristics, :exchange_characteristics, :default_redemption_characteristics,
                :default_reload_characteristics, :product_affiliation, :default_product_fees,
                :default_product_images, :default_fulfillment_characteristics, :balance_characteristics,
                :lost_stolen_characteristics

    # Initializes a new instance of product line details
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def initialize(details)
      @creator_id = details.creatorId
      @updater_id = details.updaterId
      @notes = details.notes
      @created_timestamp = details.createdTimestamp
      @updated_timestamp = details.updatedTimestamp
      @product_line_description = details.productLineDescription
      @customer_service_phone_number = details.customerServicePhoneNumber
      @customer_service_website = details.customerServiceWebsite
      @terms_and_conditions = details.termsAndConditions
      @card_number_label = details.cardNumberLabel
      @default_product_id = details.defaultProductId
      @default_currency = details.defaultCurrency
      @bank_identification_numbers = details.bankIdentificationNumbers
      @pin_required = details.pinRequired
      @supported_features = details.supportedFeatures
      @activation_type = details.activationType
      @pin_characteristics = details.pinCharacteristics
      @exchange_characteristics = details.exchangeCharacteristics
      @default_redemption_characteristics = details.defaultRedemptionCharacteristics
      @default_reload_characteristics = details.reloadReloadCharacteristics
      @product_affiliation = details.productAffiliation
      @default_product_fees = details.defaultProductFees
      @default_product_images = details.defaultProductImages
      @default_fulfillment_characteristics = details.defaultFulfillmentCharacteristics
      @balance_characteristics = details.balanceCharacteristics
      @lost_stolen_characteristics = details.lostStolenCharacteristics
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize
  end
end
