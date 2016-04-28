require 'blackhawk_api/version'
require 'blackhawk_api/client/base'
require 'httpi'

module BlackhawkApi
  # The EGift Processing API enables client applications to create wrappers around a card created by
  # Blackhawk Network so that the card can function as an eGift.
  class EGiftProcessing < RESTResource
    @@resource_url = 'eGiftProcessing/v1'

    # This operation generates an eGift for any given product configuration. The generate operation
    #  creates an account and wraps it in an eGift object, returning the fully initialized, newly created eGift.
    # @param gift_data The EGift to generate.
    # @return Returns the fully initialized, newly created EGift.
    def self.generate(gift_data, request_id, attempts = 0)
      @request = setup_request "#{@@resource_url}/generateEGift", request_id, true, attempts
      @request.body = gift_data
      @request
    end
    
    # This operation reverses an eGift activation for the given product configuration
    #  when a timeout occurs during egift activation.
    # @param gift_data The EGift to reverse
    # @return Returns the account transaction object.
    def self.reverse(gift_data, request_id, attempts = 0)
      @request = setup_request "#{@@resource_url}/reverseEGift", request_id, true, attempts
      @request.body = gift_data
      @request
    end
    
    # This operation voids an eGift specified by the provided eGift details.
    # The operation can only be used to void one eGift at a time.
    # @param gift_data The EGift to void
    # @return Returns an eGift object.
    def self.void(gift_data, request_id, attempts = 0)
      @request = setup_request "#{@@resource_url}/voidEGift", request_id, attempts
      @request.body = gift_data
      @request
    end
  end
end
