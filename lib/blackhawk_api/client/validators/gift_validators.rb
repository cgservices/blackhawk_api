require 'veto'

module BlackhawkApi
  class GenerateGiftCardRequestValidator
    include Veto.validator
    
    validates :gift_from, :presence => true
  end
end