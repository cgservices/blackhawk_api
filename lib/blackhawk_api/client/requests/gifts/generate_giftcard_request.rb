require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  # Request object to generate an egift for a given product configuration.
  class GenerateGiftCardRequest < Request
    attr_reader :gift_from, :gift_to, :gift_message, :gift_amount,
                :purchaser_id, :recipient_id, :retrieval_reference, :message_reason_code,
                :product_configuration_id, :notes, :correlation_id

    # Creates a new request object.
    def initialize(
      from, to, message, amount, purchaser_id, recipient_id,
      retrieval_reference, message_reason_code, product_configuration_id,
      notes, correlation_id)

      @gift_from = from
      @gift_to = to
      @gift_message = message
      @gift_amount = amount
      @purchaser_id = BlackhawkIdentity.new(purchaser_id) unless purchaser_id.nil?
      @recipient_id = BlackhawkIdentity.new(recipient_id) unless recipient_id.nil?
      @retrieval_reference = retrieval_reference
      @message_reason_code = message_reason_code
      @product_configuration_id = BlackhawkIdentity.new(product_configuration_id)
      @notes = notes
      @correlation_id = BlackhawkIdentity.new(correlation_id) unless correlation_id.nil?
    end

    # Formats the request data in JSON format.
    def to_json
      json_object = {}

      json_object[:giftFrom] = @gift_from unless @gift_from.nil?
      json_object[:giftTo] = @gift_to unless @gift_to.nil?
      json_object[:giftMessage] = @gift_message unless @gift_message.nil?
      json_object[:giftAmount] = @gift_amount
      json_object[:purchaserId] = @purchaser_id.to_s unless @purchaser_id.nil?
      json_object[:recipientId] = @recipient_id.to_s unless @recipient_id.nil?
      json_object[:retrievalReferenceNumber] = @retrieval_reference
      json_object[:messageReasonCode] = @message_reason_code unless @message_reason_code.nil?
      json_object[:productConfigurationId] = @product_configuration_id.to_s
      json_object[:notes] = @notes unless @notes.nil?
      json_object[:correlation_id] = @correlation_id.to_s unless @correlation_id.nil?

      JSON.generate(json_object)
    end
  end
end
