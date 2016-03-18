require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/requests/blackhawk_identity'

module BlackhawkApi
  # Request object to query a list of eGift entities for the given account_id. 
  class FindGiftsByAccountRequest < PaginatedRequest
    attr_reader :account_id
    
    # Creates a new request object.
    def initialize account_id
      @account_id = BlackhawkIdentity.new(account_id)
    end
  end
end