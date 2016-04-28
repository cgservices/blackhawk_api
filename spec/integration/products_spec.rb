require 'spec_helper'
require 'blackhawk_api/client/helpers/identity_extractor'
require 'pry'

describe BlackhawkApi do
  describe 'Read Products' do
    # 1. Call read all product catalogs
    # 2. foreach catalog in 1 call Read Product Catalog
    # 3. Call read product for every productId in 2
    # 4. foreach product call Read Product Line for additional brand information

    xit 'should read all products' do
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

    xit 'should be able to be called paginated' do
      product_service = BlackhawkApi::ProductService.new
      request = BlackhawkApi::Requests::FindProductByProvisioningTypeRequest.new(:DIGITAL)

      puts 'requesting number of products'
      products = product_service.find_by_provisioning_type request, 1, 0
      result = JSON.parse(products.raw_body, object_class: OpenStruct)
      expect(result.results.count).to be(1)
      puts " found #{result.total} products"

      products = product_service.find_by_provisioning_type request, result.total, 0
      result = JSON.parse(products.raw_body, object_class: OpenStruct)
      expect(result.results.count).to be(result.total)
    end
  end
end