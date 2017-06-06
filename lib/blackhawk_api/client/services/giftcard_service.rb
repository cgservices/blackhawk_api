require 'blackhawk_api/client/services/service_base'

module BlackhawkApi
  # Application Service for Gifts.
  class GiftService < ApplicationService
    # Initializes a new Gift Service.
    # @param gift_repository The data access for gifts.
    # @param error_handler An implementation for error handling for this service.
    def initialize(gift_repository = nil, error_handler = nil)
      super(error_handler)
      @gifts = gift_repository || GiftRepository.new
    end

    # This operation retrieves complete information about an eGift for a specified eGift identifier.
    # @param gift_id The internal identifier of the eGift.
    # @return
    def find(gift_id)
      Responses::GiftDetailsResponse.new(@gifts.find(gift_id))
    end

    # This operation generates an eGift for any given product configuration.
    # The generate operation creates an account and wraps it in an eGift object, returning the fully initialized,
    # newly created eGift.
    # @param request
    # @return Returns an eGift detail object.
    def generate(request, request_id = nil)
      request_id ||= generate_request_id
      web_response, _results = perform request do
        @gifts.generate(request, request_id)
      end
      Responses::GiftDetailsResponse.new(web_response, request_id)
    end

    # This operation reverses an eGift for the given product configuration
    # when a timeout occurs during egift activation.
    # @param request
    # @return Returns an account transaction object.
    def reverse(request, request_id = nil)
      request_id ||= generate_request_id

      web_response, _results = perform request do
        @gifts.reverse(request, request_id)
      end
      Responses::AccountTransactionResponse.new(web_response)
    end

    # This operation voids an eGift specified by the provided eGift details.
    # @param request
    # @return Returns an eGift detail object.
    def void(request, request_id = nil)
      request_id ||= generate_request_id
      web_response, _results = perform request do
        @gifts.void(request, request_id)
      end
      Responses::GiftDetailsResponse.new(web_response, request_id)
    end

    # This operation queries a list of eGift entities for the given account_id
    # @param request
    # @return
    def find_by_account_id(request)
      web_response, _results = perform request do
        @gifts.find_by_account_id request.account_id
      end
      GiftListResponse.new(web_response)
    end

    # This operation queries egift entities for the given eGift ID, or multiple eGift IDs.
    # @param request
    # @return
    def find_by_egift_ids(request)
      web_response, _results = perform request do
        @gifts.find_by_gift_ids request.gift_ids
      end
      Responses::GiftListResponse.new(web_response)
    end

    private

    def generate_request_id
      rand.to_s[2..13]
    end
  end
end
