require 'veto'

module BlackhawkApi
  module Validators
    # Validates the generation of a new giftcard.
    class GenerateGiftCardRequestValidator
      # Obfuscate the veto validator for yard
      send :include, Veto.validator

      validates :gift_amount, presence: true, greater_than: 0
      validates :product_configuration_id, presence: true
      validates :retrieval_reference, exact_length: 12
    end
    
    # Validates the void action for a gift card.
    class VoidGiftCardRequestValidator
      # Obfuscate the veto validator for yard
      send :include, Veto.validator
      
      validates :egift_id, presence: true
      validates :retrieval_reference_number, presence: true
    end
    
    # Validates the reversal action for a gift card.
    class ReverseGiftCardRequestValidator
      # Obfuscate the veto validator for yard
      send :include, Veto.validator
      
      validates :reversal_egift_request_id, presence: true
    end
  end
end