require 'spec_helper'
require 'pry'

HttpLog.options[:logger]        = Logger.new($stdout)
HttpLog.options[:severity]      = Logger::Severity::INFO
HttpLog.options[:log_connect]   = false
HttpLog.options[:log_request]   = true
HttpLog.options[:log_headers]   = true
HttpLog.options[:log_data]      = true
HttpLog.options[:log_status]    = true
HttpLog.options[:log_response]  = true
HttpLog.options[:log_benchmark] = false

describe BlackhawkApi do
  describe 'Account Processing' do
    VALID_ACCOUNT_ID = 'J5FZ4KAC98LALH5WC9GHA47DDC'.freeze
    INVALID_ACCOUNT_ID = '000000AC900000000000047111'.freeze
    
    describe 'Read Account' do
      it 'should call read account with the account id from the eGift json and return account information: account number, security code, cached balance, currency and product line id' do
        service = BlackhawkApi::AccountService.new
        
        result = service.find(VALID_ACCOUNT_ID)
        
        expect(result.code).to eq(200)
        expect(result.information).not_to eq(nil)
        expect(result.information.type).to eq("GIFT_CARD")
        expect(result.information.status).to eq("ACTIVATED")
        expect(result.information.product_id).not_to eq(nil)
      end
      
      it 'should call read account with an invalid account id from the eGift json and return 404 - invalid id, 400 - bad request' do
        service = BlackhawkApi::AccountService.new
        
        expect {
          service.find(INVALID_ACCOUNT_ID)
        }.to raise_error(BlackhawkApi::ApiError)
      end
    end
  end
  
  describe 'Account Transaction' do
    describe 'Read Account Transaction' do
      INVALID_REQUEST_ID = ''
      it 'should call Read Account Transaction and return the full account transaction for the specified Account Transaction identifier' do
        
        pending('Account Transactions not tested yet')
        fail
      end
      
      it 'should call Read Account Transaction with invalid requestId and return http status code of 400 - EntityNotFound' do
        
        pending('Account Transactions not tested yet')
        fail
      end
    end
  end
  
  describe 'Product Catalog Management' do
    describe 'Read Product Catalog' do
      VALID_CATALOG_ID = 'R7N2G9WKC9CKHJ5FSS37T41RMH'.freeze
      INVALID_CATALOG_ID = '123456789012'.freeze
      
      it 'should Call API with catalog ID and return product ids of products within the catalog' do
        service = BlackhawkApi::CatalogService.new
        
        result = service.find(VALID_CATALOG_ID)
        
        expect(result.code).to eq(200)
        expect(result.details).not_to eq(nil)
        expect(result.details.product_urls.length).to be > 0
      end
      
      it 'should call API with invalid Catalog ID and return 404 - invalid id, 400 - bad request' do
        service = BlackhawkApi::CatalogService.new
        
        expect {
          service.find(INVALID_CATALOG_ID) 
        }.to raise_error(BlackhawkApi::ApiError)        
      end
    end
    
    describe 'Get Product Catalog Version' do
      it 'should call API with valid Catalog ID of test case 1 and return the product catalog version' do
        service = BlackhawkApi::CatalogService.new
        
        result = service.get_version(VALID_CATALOG_ID)
        
        expect(result.code).to eq(200)
        expect(result.version.to_i).to be > 0
      end
    end
    
    describe 'Query all product catalogs' do
      it 'should query all product catalogs with relevant info and return the ID, version and name of one catalog' do
        service = BlackhawkApi::CatalogService.new
        
        result = service.all
        
        expect(result.code).to eq(200)
        expect(result.results.length).to be 1
        expect(result.results[0].entity_id.length).to eq(26)
        expect(result.results[0].version.to_i).to be > 0
        expect(result.results[0].name.length).to be > 0
      end
      
      it 'should query product catalog with an invalid element and return 400 - invalid attributes' do
        
        pending('Not used yet')
        fail
      end
    end
    
    describe 'Product Management' do
      it 'should handle the return of Service not Available or Bad Gateway' do
        
        pending('BHN needed -> Simulate Service Not Available')
        fail
      end
    end
    
    describe 'Query all Product Catalogs' do
      it 'should call API with no input and return the ID, version and name of 1 catalog' do
        service = BlackhawkApi::CatalogService.new
        
        result = service.all
        
        expect(result.code).to eq(200)
        expect(result.results.length).to be > 0
        expect(result.results[0].entity_id.length).to eq(26)
        expect(result.results[0].version.to_i).to be > 0
        expect(result.results[0].name.length).to be > 0
      end
    end
  end
  
  describe 'Product Management' do
    describe 'Read Product' do
      VALID_PRODUCT_ID = 'WH7V1Z5584XM0XGZ7JS61C7FHW'
      INVALID_PRODUCT_ID = '123456789012'
      it 'should read product with the product id in catalog and return valid json' do
        service = BlackhawkApi::ProductService.new
        
        result = service.find VALID_PRODUCT_ID
        
        expect(result.code).to eq(200)
        expect(result.summary).not_to eq(nil)
        expect(result.summary.product_name.length).to be > 0
        expect(result.details).not_to eq(nil)
        expect(result.details.product_configurations).not_to eq(nil)
      end
      
      it 'should read product with a bad product id and handle a 404 - invalid id, 400 - Bad Request' do
        service = BlackhawkApi::ProductService.new
        
        expect {
          service.find INVALID_PRODUCT_ID
        }.to raise_error(BlackhawkApi::ApiError)
      end
    end
    
    describe 'Query Products By' do
      it 'should return json with the list of summary information about a subset of the product that meets the specified criteria and cursor view parameters' do
        
        pending('Not used')
        fail
      end
      
      it 'should call query with an invalid element and return 400 - invalid attributes' do
      
        pending('Not used')
        fail
      end
    end
    
    describe 'Product Management' do
      it 'should handle Product management service unavailable with 502, 503 - Service not available or Bad Gateway' do
        
        pending('BHN needed -> Simulate Service Unavailable')
        fail
      end
    end
  end
  
  describe 'eGift Processing' do
    describe 'generate eGift' do
      VALID_CONFIG_ID = 'SNPZWSWTQHWYCF4THKMPFK5ZH0'.freeze
      INVALID_CONFIG_ID = '123456789012'.freeze
      OTHER_CONFIG_ID = ''.freeze
      
      it 'should be called with a valid configuration id and return a valid eGift json' do
        amount = 5
        reference = rand.to_s[2..13]
        client = BlackhawkApi::BlackhawkClient.new
        
        result = client.generate_egift(VALID_CONFIG_ID, amount, reference)
        
        expect(result.code).to eq(200)
        expect(result.information).not_to be(nil)
        expect(result.information.gift_amount).to eq(amount)
        expect(result.information.status).to eq('ACTIVATED')
        expect(result.information.suspended).to eq(false)
        expect(result.information.product_configuration_id).to eq(VALID_CONFIG_ID)        
      end
      
      it 'should be called with invalid amount and return 400 giftamount null' do
        amount = 0
        reference = rand.to_s[2..13]
        client = BlackhawkApi::BlackhawkClient.new
        
        expect {
          client.generate_egift(VALID_CONFIG_ID, amount, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called with an invalid purchase id and return purchaserId null' do
        pending('PurchaserId Not used yet')
        fail
      end
      
      it 'should be called with null configuration id and return productConfigurationId.null' do
        pending('Not possible yet due to argument validations')
        fail
        
        amount = 5
        reference = rand.to_s[2..13]
        client = BlackhawkApi::BlackhawkClient.new
        
        expect {
          client.generate_egift(nil, amount, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called with invalid configuration id and return 409 product not found' do
        amount = 5
        reference = rand.to_s[2..13]
        client = BlackhawkApi::BlackhawkClient.new
        
        expect {
          client.generate_egift(INVALID_CONFIG_ID, amount, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called while not part of the clients configuration and return 409 product not in catalog' do
        pending('BHN needed -> Get `other` config')
        fail
        
        amount = 5
        reference = rand.to_s[2..13]
        client = BlackhawkApi::BlackhawkClient.new
        
        expect {
          client.generate_egift(OTHER_CONFIG_ID, amount, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called with invalid value and return 409 account creation failed' do
        pending('BHN needed -> what is `invalid` value?')
        fail
      end
      
      it 'should be caled with invalid value and return 409 egift creation failed' do
        pending('BHN needed -> what is `invalid` value?')
        fail
      end
      
      it 'should be called when the service is unavailable and return Service Not Available / Bad Gateway' do
        pending('BHN needed')
        fail
      end
      
      it 'should be called when Blast is down and return timeout with the processor' do
        pending('BHN needed Blast?')
        fail
      end
      
      it 'should be called when product is not available and return product inventory is not available' do
        pending('BHN needed -> which is not available?')
        fail
      end
    end
    
    describe 'Accept eGift' do
      VALID_CONFIG_ID = 'SNPZWSWTQHWYCF4THKMPFK5ZH0'.freeze
      OTHER_CONFIG_ID = ''.freeze
      
      it 'should be called with a valid egift ID from step 1 and return eGift JSON with AccountID populated' do
        pending('Not used yet')
        fail
      end
      
      it 'should be called with a configuration id of a product not in the catalog and return 409 - product not in catalog' do
        pending('BHN needed -> Get `other` config id')
        fail
      end
      
      it 'should be called when the processor is down and return a timeout with the processor' do
        pending('BHN needed -> Simulate processor down')
        fail
      end
      
      it 'should be called when Blast is down and return timeout with the processor' do
        pending('BHN needed -> Simulate Blast down')
        fail
      end
    end
    
    describe 'Void eGift' do
      INVALID_EGIFT_ID = '123456789012'.freeze
      VALID_CONFIG_ID = 'SNPZWSWTQHWYCF4THKMPFK5ZH0'.freeze
      
      it 'should be called with a valid egift id and return a valid eGift json' do
        client = BlackhawkApi::BlackhawkClient.new
        reference = rand.to_s[2..13]
        amount = 5
        egift = client.generate_egift(VALID_CONFIG_ID, amount, reference)
        id = BlackhawkApi::IdentityExtractor.to_identity(egift.information.entity_id)
        
        result = client.void_egift(egift.request_id, id, reference)
        
        expect(result.code).to eq(200)
        expect(result.information).not_to eq(nil)
        expect(result.information.gift_amount).to eq(amount)
        expect(result.information.product_configuration_id).to eq(VALID_CONFIG_ID)
        expect(result.information.status).to eq("ACTIVATED")
        expect(result.information.suspended).to eq(false)
      end
      
      it 'should be called with an invalid egift id and return egift not found' do
        client = BlackhawkApi::BlackhawkClient.new
        reference = rand.to_s[2..13]
        amount = 5
        INVALID_EGIFT_ID = '00100001000000100001010111'
        egift = client.generate_egift(VALID_CONFIG_ID, amount, reference)
        
        expect {
          client.void_egift(egift.request_id, INVALID_EGIFT_ID, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called when eGift is already voided OR underlying account is already closed and return egift already voided' do
        client = BlackhawkApi::BlackhawkClient.new
        reference = rand.to_s[2..13]
        amount = 5

        egift = client.generate_egift(VALID_CONFIG_ID, amount, reference)
        id = BlackhawkApi::IdentityExtractor.to_identity(egift.information.entity_id)
        # Perform initial void
        client.void_egift(egift.request_id, id, reference)
        
        expect {
          client.void_egift(egift.request_id, id, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
    end
    
    describe 'eGift Processing' do
      it 'should be called when the service is unavailable and return Service Not Available or Bad Gateway' do
        pending('BHN needed -> Simulate Service Unavailable')
        fail
      end
      
      it 'should be called with a timeout and return ws.provider.timeout' do
        pending('BHN needed -> Simulate Timeout')
        fail
      end
    end
  end
end