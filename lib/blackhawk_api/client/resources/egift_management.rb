module BlackhawkApi
  # The EGift Management API enables client applications to manage eGifts by reading eGifts information
  # and querying eGifts by account ID and other criteria.
  class EGiftManagement < RESTResource
    @@resource_url = 'eGiftManagement/v1/eGifts'

    def initialize(config)
      super(config)
    end

    # This operation retrieves complete information about an eGift for a specified eGift identifier.
    # @param egift_id The internal identifier of the eGift.
    # @return The requested eGift.
    def find(egift_id)
      @request = setup_request @@resource_url.to_s
      @request.query = { eGiftIds: egift_id}
      @request
    end

    # This operation queries a list of eGift entities for the given account_id.
    # @param account_id The internal identifiers for the account tied to the eGift.
    # @return Retrieves a list of matching EGift entities and the total number of existing in the system matching the given account ID.
    def find_by_account_id(account_id)
      @request = setup_request @@resource_url.to_s
      @request.query = { accountId: account_id }
      @request
    end

    # This operation queries egift entities for the given eGift ID, or for multiple eGift IDs.
    # @param egift_ids The internal identifiers for the eGifts.
    # @return The list of matching eGift entries and the total number of entities existing in the system matching the
    #  given eGift ID (or multiple IDs)
    def find_by_egift_ids(egift_ids)
      @request = setup_request @@resource_url.to_s
      @request.query = { eGiftIds: egift_ids.join(';') }
      @request
    end
  end
end
