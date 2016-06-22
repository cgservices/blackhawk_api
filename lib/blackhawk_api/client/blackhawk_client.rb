module BlackhawkApi
  # Facade to enable easy access to the Blackhawk API.
  class BlackhawkClient
    # Reads all products for all available catalogs.
    # @return An array with catalogs, each with an array of products for that catalog.
    def read_catalogs
      catalog_service = BlackhawkApi::CatalogService.new
      product_service = BlackhawkApi::ProductService.new
      available_catalogs = []

      catalogs = catalog_service.all BlackhawkApi::Requests::GetAllCatalogsRequest.new
      catalogs.results.each do |c|
        catalog_details = []
        catalog = catalog_service.find c.entity_id
        ids = []
        catalog.details.product_urls.each do |url|
          ids << BlackhawkApi::IdentityExtractor.to_identity(url).to_s
        end

        ids.each do |id|
          product = product_service.find id
          catalog_details << product
        end

        available_catalogs << catalog_details
      end
      available_catalogs
    end

    # Reads product details for a single product.
    # @param product_id The identifier of the product.
    # @return The product details.
    def read_product product_id
      product_service = BlackhawkApi::ProductService.new
      product_service.find product_id
    end

    # Reads account details for a single account
    # @param account_id The identifier of the account.
    # @return The account details.
    def read_account account_id
      account_service = BlackhawkApi::AccountService.new
      account_service.find account_id
    end

    # Reads transaction details for a single transaction.
    # @param transaction_id The identifier of the transaction.
    # @return The transaction details.
    def read_transaction transaction_id
      transaction_service = BlackhawkApi::TransactionService.new
      transaction_service.find transaction_id
    end

    # Finds transactions for the specified account.
    # @param account_id The identifier of the account.
    # @return All transaction details for the account.
    def read_transactions_for_account account_id
      transaction_service = BlackhawkApi::TransactionService.new
      request = BlackhawkApi::Requests::FindAccountTransactionsByAccountIdRequest.new(account_id)

      transaction_service.find_by_account_id request
    end

    # Generates an egift for the specified product configuration.
    # @param product_config_id The identifier for the product configuration.
    # @param amount The requested value for the egift.
    # @param reference The reference to perform transaction based operations on this egift.
    # @return The EGift details.
    def generate_egift product_config_id, amount, reference
      gift_service = BlackhawkApi::GiftService.new

      request = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
        nil, nil, nil, amount, nil, nil, reference,
        nil, product_config_id, nil, nil
      )

      gift_service.generate request, reference
    end

    # Reverses a generated egift or a voided egift.
    # @param request_id The identifier used during the initial request.
    # @return The account transaction details.
    def reverse_egift request_id
      gift_service = BlackhawkApi::GiftService.new

      request = BlackhawkApi::Requests::ReverseGiftCardRequest.new(request_id)

      gift_service.reverse request
    end

    # Voids a generated egift.
    # @param request_id The identifier used during the initial request.
    # @param egift_id The identifier given to the generated egift.
    # @param reference The reference used during the generation process.
    # @return The EGift details
    def void_egift egift_id, reference
      gift_service = BlackhawkApi::GiftService.new

      request = BlackhawkApi::Requests::VoidGiftCardRequest.new(
        egift_id, reference)

      gift_service.void request
    end
  end
end
