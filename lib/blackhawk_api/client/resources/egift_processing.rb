require "blackhawk_api/version"
require "blackhawk_api/client/base"
require 'httpi'

module BlackhawkApi
  class EGiftProcessing < RESTResource
    @@resource_url = 'eGiftProcessing/v1'
    
    # This operation generates an eGift for any given product configuration. The generate operation
    #  creates an account and wraps it in an eGift object, returning the fuly initialized, newly created eGift.
    # @param giftFrom EGift sender details.
    # @param giftTo EGift receiver details.
    # @param giftMessage Gift message.
    # @param giftAmount The amount associated with the egift.
    # @param purchaserId A reference to the URI of the person who is purchasing the egift.
    # @param recipientId A reference to the URI for the recipient person.
    # @param retrievalReferenceNumber Retrieval reference number for the egift transaction, as 12 numeric numbers.
    # @param messageReasonCode Enables client to enter reason why egift is being created.
    # @param productConfigurationId The product configuration ID of any of the configurations tied to the egift product.
    # @param notes Any notes associated with the last time the entity was updated.
    # @return Returns the fully initialized, newly created EGift.
    def self.generate (gift_from, gift_to, gift_message, gift_amount,
      purchaser_id, recipient_id, retrievalReferenceNumber, messageReasonCode, 
      productConfigurationId, notes, correlationId)
      @request = self.setup_request "#{@@resource_url}/generateEGift"
      # TODO: @request.headers["contractId"] =
      # TODO: Set body @request.body = 
      parse_response HTTPI.post @request
    end
  end
end