require 'veto'

module BlackhawkApi
  # Validates the generation of a new giftcard.
  class GenerateGiftCardRequestValidator
    include Veto.validator

    validates :gift_amount, presence: true, greater_than: 0
    validates :product_configuration_id, presence: true
    validates :retrieval_reference, exact_length: 12
  end
end
