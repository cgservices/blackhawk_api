module BlackhawkApi
  # Facade to enable easy access to the Blackhawk API.
  class BlackhawkClient
    include HttpClient
    include RequestHandler

    def initialize(config)
      @config = config
    end

    # Reads product details for a single product.
    # @param product_id The identifier of the product.
    # @return The product details.
    def read_product(product_id)
      request = Requests::FindProductByIdRequest.new(product_id)

      web_response, _results = perform request do
        http_request = Product.new(@config).find(request.product_id)
        get http_request
      end

      Responses::ProductDetailsResponse.new(web_response)
    end

    # Reads account details for a single account
    # @param account_id The identifier of the account.
    # @return The account details.
    def read_account(account_id)
      request = Requests::FindAccountRequest.new(account_id)

      web_response, _results = perform request do
        get AccountProcessingInformation.new(@config).find(request.account_id)
      end

      Responses::AccountDetailsResponse.new(web_response)
    end

    # Generates an egift for the specified product configuration.
    # @param product_config_id The identifier for the product configuration.
    # @param amount The requested value for the egift.
    # @param reference The reference to perform transaction based operations on this egift.
    # @return The EGift details.
    def generate_egift(product_config_id, amount, reference)
      request = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
        nil, nil, nil, amount, nil, nil, reference,
        nil, product_config_id, nil, nil
      )

      reference ||= generate_request_id
      web_response, _results = perform request do
        post EGiftProcessing.new(@config).generate(request.to_json, reference)
      end

      Responses::GiftDetailsResponse.new(web_response, reference)
    end

    # Reverses a generated egift or a voided egift.
    # @param request_id The identifier used during the initial request.
    # @return The account transaction details.
    def reverse_egift(request_id)
      request = BlackhawkApi::Requests::ReverseGiftCardRequest.new(request_id)
      request_id ||= generate_request_id

      web_response, _results = perform request do
        post EGiftProcessing.new(@config).reverse(request.to_json, request_id)
      end

      Responses::AccountTransactionResponse.new(web_response)
    end

    # Voids a generated egift.
    # @param egift_id The identifier given to the generated egift.
    # @param reference The reference used during the generation process.
    # @return The EGift details
    def void_egift(egift_id, reference)
      request = BlackhawkApi::Requests::VoidGiftCardRequest.new(egift_id, reference)
      request_id ||= generate_request_id

      web_response, _results = perform request do
        post EGiftProcessing.new(@config).void(request.to_json, request_id)
      end

      Responses::GiftDetailsResponse.new(web_response, request_id)
    end
  end
end
