require 'blackhawk_api/client/dto/offer_details'

module BlackhawkApi
  # Data class for gift details
  class GiftDetails
    attr_reader :entity_id, :creator_id, :updater_id, :created_timestamp, :updated_timestamp,
                :notes, :gift_from, :gift_to, :gift_message, :recipient_id, :account_id,
                :product_configuration_id, :gift_amount, :gift_currency, :is_void,
                :offer_details, :purchaser_id, :retrieval_reference_number, :status, :suspended,
                :has_been_viewed, :security_questions

    # Initializes a new instance of GiftDetails
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def initialize(details)
      @entity_id = details.entityId
      @creator_id = details.creatorId
      @updater_id = details.updaterId
      @created_timestamp = details.createdTimestamp
      @updated_timestamp = details.updatedTimestamp
      @gift_from = details.giftFrom
      @gift_to = details.giftTo
      @gift_message = details.giftMessage
      @recipient_id = details.recipientId
      @account_id = details.accountId
      @purchaser_id = details.purchaserId
      @reference_number = details.referenceNumber
      @product_configuration_id = details.productConfigurationId
      @gift_amount = details.giftAmount
      @gift_currency = details.giftCurrency
      @is_void = details.isVoid
      @offer_details = OfferDetails.new(details.offerDetails) unless details.offerDetails.nil?
      @status = details.status
      @suspended = details.suspended
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/AbcSize
  end
end
