require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  # Request object to query a list of eGift entities for the given account_id. 
  class FindGiftsByAccountRequest < PaginatedRequest
    attr_reader :account_id
    
    # Creates a new request object.
    def initialize account_id
      @account_id = account_id
    end
  end
  
  # Request object to query egift entities for the given eGift IDs.
  class FindGiftsByIdsRequest < PaginatedRequest
    attr_reader :gift_ids
    
    # Creates a new request object.
    def initialize(egift_ids)
      @gift_ids = egift_ids.join(';') 
    end
  end

  # Request object to generate an egift for a given product configuration.
  class GenerateGiftCardRequest < Request
    attr_reader :gift_from, :gift_to, :gift_message, :gift_amount,
      :purchaser_id, :recipient_id, :retrieval_reference, :message_reason_code,
      :product_configuration_id, :notes, :correlation_id
      
    # Creates a new request object.
    def initialize(from, to, message, amount, purchaser_id, recipient_id,
      retrieval_reference, message_reason_code, product_configuration_id,
      notes, correlation_id)
      
      @gift_from = from
      @gift_to = to
      @gift_message = message
      @gift_amount = amount
      @purchaser_id = purchaser_id
      @recipient_id = recipient_id
      @retrieval_reference = retrieval_reference
      @message_reason_code = message_reason_code
      @product_configuration_id = product_configuration_id
      @notes = notes
      @correlation_id = correlation_id
    end
  end
end