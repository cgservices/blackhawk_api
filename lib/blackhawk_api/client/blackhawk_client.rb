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
      
      gift_service.generate request
    end
    
    # Reverses a generated egift or a voided egift.
    # @param request_id The identifier used during the initial request.
    # @return The account transaction details.
    def reverse_egift request_id
      gift_service = BlackhawkApi::GiftService.new
      
      request = BlackhawkApi::Requests::ReverseGiftCardRequest.new(request_id)
      
      gift_service.reverse request, request_id
    end
    
    # Voids a generated egift.
    # @param request_id The identifier used during the initial request.
    # @param egift_id The identifier given to the generated egift.
    # @param reference The reference used during the generation process.
    # @return The EGift details
    def void_egift request_id, egift_id, reference
      gift_service = BlackhawkApi::GiftService.new
      
      request = BlackhawkApi::Requests::VoidGiftCardRequest.new(
        egift_id, reference)
      
      gift_service.void request, request_id
    end
  end
end