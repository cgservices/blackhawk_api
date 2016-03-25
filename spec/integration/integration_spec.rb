require 'spec_helper'
require 'blackhawk_api/client/helpers/identity_extractor'

describe BlackhawkApi do
  describe 'Read Products' do
    # 1. Call read all product catalogs
    # 2. foreach catalog in 1 call Read Product Catalog
    # 3. Call read product for every productId in 2
    # 4. foreach product call Read Product Line for additional brand information
    
    it 'should read all products' do
      catalog_service = BlackhawkApi::CatalogService.new()
      product_service = BlackhawkApi::ProductService.new()
      productline_service = BlackhawkApi::ProductLineService.new()
      
      step_1 = BlackhawkApi::GetAllCatalogsRequest.new()
      catalogs = catalog_service.all step_1
      catalogs.results.each do |c|
        puts "---- Processing Catalog #{c} ----"
        catalog_details = catalog_service.find c.entity_id
        ids = []
        catalog_details.details.product_urls.each do |details|
          ids << BlackhawkApi::IdentityExtractor.to_identity(details).to_s
        end
        step_3 = BlackhawkApi::FindProductsByIdsRequest.new(ids)
        summaries = product_service.find_by_ids step_3
        product_lines = []
        product_lines << summaries.results.map { |v| BlackhawkApi::IdentityExtractor.to_identity(v.product_line_url).to_s }.flatten
        puts '---- Retrieving Product Details ---'
        ids.each do |id|
          product = product_service.find id
          puts "#{product.summary.product_name} #{product.summary.currency} #{product.details.activation_characteristics.baseValueAmount}"
          product_line = productline_service.find BlackhawkApi::IdentityExtractor.to_identity(product.summary.product_line_url).to_s
          puts product_line.summary.brand_name
        end
      end
    end
  end
  
  describe 'Create Gift Card' do
  # 1. Select product
  # 2. Call generateEGift
  #  unique val for requestId
  #  set egift amount to giftAmount
  #  set productConfigurationId
  #  set retrievalReferenceNumber
  # 3. If 2 fails with no response:
  #  call generateEGift with the same parameters
  #  set previousAttempts to 1 and increment by 1
  #  if no response ..
  #   call reverseEGift
  #    set reversalEGiftRequestId to requestId from 2
  #   if reverseEGift does not respond, call Blackhawk Service
  # 4. If 2 fails with 504 or 502
  #  Call reverse EGift mapping the request ID from 2
  #   if reverse EGift does not respond, call Blackhawk Service
  # 5. Present EGift
    VALID_PRODUCT_ID = '0K37ZQFK8WTNVJM1AVTKV1C3Z8'
    VALID_CONFIG_ID = 'JRSXXV9CFKJQ2Y2G78XT0QN9VM'
    it 'should create a gift card' do
      gift_service = BlackhawkApi::GiftService.new()
      amount = 10
      ref = rand.to_s[2..13]
      
      puts "Reference used: #{ref}"
      
      step_2 = BlackhawkApi::GenerateGiftCardRequest.new(nil, nil, nil, amount, nil, nil, ref,
        nil, VALID_CONFIG_ID, nil, nil)
        binding.pry
      response = gift_service.generate step_2
      
      puts response
    end
  end
end