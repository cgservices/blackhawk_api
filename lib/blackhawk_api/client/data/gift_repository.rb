require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/client'

module BlackhawkApi
  # Repository for eGifts.
  class GiftRepository < Client
    # This operation retrieves complete information about an eGift for a specified egift identifier.
    # @param gift_id The identifier of the registered eGift.
    # @return Returns the HTTP response of the GET request.
    def find(gift_id)
      get EGiftManagement.find gift_id
    end

    # This operation queries eGift entities for the given account_id.
    # @param account_id The identifier of the account to find eGifts for.
    # @return Returns the HTTP response of the GET request with eGifts for the account.
    def find_by_account_id(account_id)
      get EGiftManagement.find_by_account_id account_id
    end

    # This operation queries eGift entities for the given eGift ID's.
    # @param egift_ids The identifiers of eGifts to find.
    # @return Returns the HTTP response of the GET request with the found eGifts.
    def find_by_gift_ids(egift_ids)
      get EGiftManagement.find_by_egift_ids egift_ids
    end

    # This operation generates an eGift for any given product configuration.
    # @param request The request object to generate an eGift.
    # @return Returns the HTTP response of the POST request.
    def generate(request, request_id)
      post EGiftProcessing.generate request.to_json, request_id
    end

    # This operation reverses an eGift activation for the given product configuration
    # when a timeout occurs during egift activation.
    # @param request The request object to reverse an eGift.
    # @return Returns the HTTP response of the POST request.
    def reverse(request, request_id)
      post EGiftProcessing.reverse request.to_json, request_id
    end
    
    # This operation voids an eGift specified by the provided eGift details.
    # @param request The request object to void an eGift.
    # @return Returns the HTTP response of the POST request.
    def void(request, request_id)
      post EGiftProcessing.void request.to_json, request_id
    end
  end
end
