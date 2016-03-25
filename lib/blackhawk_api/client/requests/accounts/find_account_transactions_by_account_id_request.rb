require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  
  class FindAccountTransactionsByAccountIdRequest < PaginatedRequest
    attr_reader :account_id
    
    def initialize(account_id)
      @account_id = BlackhawkIdentity.new(account_id)
    end
  end
end