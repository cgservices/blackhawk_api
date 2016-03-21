module BlackhawkApi
  class OfferDetails
    attr_reader :offer_definition_id, :offer_instance_id, :offer_amount, :offer_currency
    
    def initialize(details)
      @offer_definition_id = details.offerDefinitionId
      @offer_instance_id = details.offerInstanceId
      @offer_amount = details.offerAmount
      @offer_currency = details.offerCurrency
    end
  end
end