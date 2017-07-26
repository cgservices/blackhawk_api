module BlackhawkApi
  # Facade to enable easy access to the Blackhawk API.
  class BlackhawkClient
    include HttpClient
    include RequestHandler

    def initialize(config)
      @config = config
    end

    def read_product_catalogs
      result = get(ProductCatalog.new(@config).all)
      Responses::ProductCatalogsResponse.new(result)
    end

    def read_catalog(catalog_id)
      request = Requests::FindCatalogByIdRequest.new(catalog_id)

      web_response, _results = perform request do
        get ProductCatalog.new(@config).find(request.catalog_id)
      end

      Responses::ProductCatalogDetailsResponse.new(web_response)
    end

    def read_productline(productline_id)
      result = get(ProductLine.new(@config).find(productline_id))
      Responses::ProductLineDetailsResponse.new(result)
    end

    def read_product(product_id)
      request = Requests::FindProductByIdRequest.new(product_id)

      web_response, _results = perform request do
        get Product.new(@config).find(request.product_id)
      end

      Responses::ProductDetailsResponse.new(web_response)
    end

    def read_account(account_id)
      request = Requests::FindAccountRequest.new(account_id)

      web_response, _results = perform request do
        get AccountProcessingInformation.new(@config).find(request.account_id)
      end

      Responses::AccountDetailsResponse.new(web_response)
    end

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

    def reverse_egift(request_id)
      request = BlackhawkApi::Requests::ReverseGiftCardRequest.new(request_id)
      request_id ||= generate_request_id

      web_response, _results = perform request do
        post EGiftProcessing.new(@config).reverse(request.to_json, request_id)
      end

      Responses::AccountTransactionResponse.new(web_response)
    end

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
