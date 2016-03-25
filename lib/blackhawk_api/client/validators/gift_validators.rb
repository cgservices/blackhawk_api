require 'veto'

module BlackhawkApi
  class GenerateGiftCardRequestValidator
    include Veto.validator
    
    validates :gift_amount, :presence => true, :greater_than => 0
    validates :product_configuration_id, :presence => true
    validates :retrieval_reference, :exact_length => 12
  end
end