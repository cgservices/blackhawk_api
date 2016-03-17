require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/client'

module BlackhawkApi
  class GiftRepository < Client
    # This operation retrieves complete information about an eGift for a specified egift identifier.
    def find gift_id
      get EGiftManagement.find gift_id
    end
    
    # This operation queries eGift entities for the given account_id.
    def find_by_account_id account_id
      get EGiftManagement.find_by_account_id account_id
    end
    
    # This operation queries eGift entities for the given eGift ID's.
    def find_by_gift_ids egift_ids
      get EGiftManagement.find_by_egift_ids egift_ids
    end
    
    # This operation generates an eGift for any given product configuration.
    def generate request
      # TODO: post EGiftProcessing.generate request.params 
    end
  end
end