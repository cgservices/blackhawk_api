require 'spec_helper'
require 'blackhawk_api/client/helpers/identity_extractor'
require 'pry'

describe BlackhawkApi do
  describe 'Read Products' do
    # 1. Call read all product catalogs
    # 2. foreach catalog in 1 call Read Product Catalog
    # 3. Call read product for every productId in 2
    # 4. foreach product call Read Product Line for additional brand information
    it 'should read all products' do
      catalog_service = BlackhawkApi::CatalogService.new
      product_service = BlackhawkApi::ProductService.new
      productline_service = BlackhawkApi::ProductLineService.new

      step_1 = BlackhawkApi::Requests::GetAllCatalogsRequest.new
      catalogs = catalog_service.all step_1
      catalogs.results.each do |c|
        puts "---- Processing Catalog #{c} ----"
        catalog_details = catalog_service.find c.entity_id
        ids = []
        catalog_details.details.product_urls.each do |details|
          ids << BlackhawkApi::IdentityExtractor.to_identity(details).to_s
        end
        step_3 = BlackhawkApi::Requests::FindProductsByIdsRequest.new(ids)
        summaries = product_service.find_by_ids step_3
        product_lines = []
        product_lines << summaries.results.map { |v| BlackhawkApi::IdentityExtractor.to_identity(v.product_line_url).to_s }.flatten
        puts '---- Retrieving Product Details ---'
        ids.each do |id|
          product = product_service.find id
          puts "#{id}: #{product.summary.product_name} #{product.summary.currency} #{product.details.activation_characteristics.baseValueAmount}"
          product_line = productline_service.find BlackhawkApi::IdentityExtractor.to_identity(product.summary.product_line_url).to_s
          puts "Brand: #{product_line.summary.brand_name}"
        end
      end
    end

    # 1. Perform 'dummy' request to get the amount of products available for subsequent requests
    # 2. Perform request to get all products with the resultcount from request 1
    xit 'should be able to be called paginated' do
      product_service = BlackhawkApi::ProductService.new
      request = BlackhawkApi::Requests::FindProductByProvisioningTypeRequest.new(:DIGITAL)

      puts 'requesting number of products'
      products = product_service.find_by_provisioning_type request, 0, 1
      result = JSON.parse(products.raw_body, object_class: OpenStruct)
      expect(result.results.count).to be(1)
      puts " found #{result.total} products"

      products = product_service.find_by_provisioning_type request, 0, result.total
      result = JSON.parse(products.raw_body, object_class: OpenStruct)
      expect(result.results.count).to be(result.total)
    end
    
     describe 'Product Management' do
      VALID_PRODUCT_ID = 'WH7V1Z5584XM0XGZ7JS61C7FHW'

      class ServiceTester
        def initialize(service, requested_status, requested_error)
          @service = service
          @requested_status = requested_status
          @requested_error = requested_error
        end
        
        def find product_id
          @service.find product_id do |request|
            request.headers['requestedStatusCode'] = @requested_status
            request.headers['requestedErrorCode'] = @requested_error
            request
          end
        end
      end
    
      it 'should handle Product management service unavailable with 502, 503 - Service not available or Bad Gateway' do
        service = BlackhawkApi::ProductService.new
        service_tester = ServiceTester.new(service, '500', 'Internal Server Error')
        
        expect { service_tester.find VALID_PRODUCT_ID }.to raise_error
      end
    end
  end
end