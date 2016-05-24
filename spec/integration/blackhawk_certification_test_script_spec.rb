require 'spec_helper'
require 'pry'

describe BlackhawkApi do
  context 'Account Processing', :account_processing => true do
    describe 'Read Account' do
      it 'should call read account with the account id from the eGift json and return account information: account number, security code, cached balance, currency and product line id' do
        valid_account_id = 'J5FZ4KAC98LALH5WC9GHA47DDC'.freeze
        service = BlackhawkApi::AccountService.new
        
        result = service.find(valid_account_id)
        
        expect(result.code).to eq(200)
        expect(result.information).not_to eq(nil)
        expect(result.information.type).to eq("GIFT_CARD")
        expect(result.information.status).to eq("ACTIVATED")
        expect(result.information.product_id).not_to eq(nil)
      end
      
      it 'should call read account with an invalid account id from the eGift json and return 404 - invalid id, 400 - bad request' do
        invalid_account_id =  '000000AC9000000000000471'.freeze
        service = BlackhawkApi::AccountService.new
        
        expect {
          service.find(invalid_account_id)
        }.to raise_error { | error |
          puts error
          expect(error.http_code).to eq(400)
          expect(error.error_code).to eq('com.bhn.general.invalid.argument')
        }
      end
    end
  end
  
  context 'Product Catalog Management', :product_catalog => true do
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
        skip
      end
    end
    
    describe 'Product Management' do
      it 'should handle the return of Service not Available or Bad Gateway' do
        skip
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
  
  context 'Product Management', :product_management => true do
    VALID_PRODUCT_ID = 'WH7V1Z5584XM0XGZ7JS61C7FHW'
    INVALID_PRODUCT_ID = '123456789012'
    
    describe 'Read Product' do
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
        skip
      end
      
      it 'should call query with an invalid element and return 400 - invalid attributes' do
        skip
      end
    end

    describe 'Product Management' do
      it 'should handle Product management service unavailable with 502, 503 - Service not available or Bad Gateway' do
        service = BlackhawkApi::ProductService.new
        expect {
          service.find '8MJAB7C7P6NZ7YAH8P6N7W2NTL'
        }.to raise_error(BlackhawkApi::ApiError)        
      end
    end
  end
  
  context 'eGift Processing', :egift_processing => true do
    describe 'Generate eGift' do
      VALID_CONFIG_ID = 'SNPZWSWTQHWYCF4THKMPFK5ZH0'.freeze
      INVALID_CONFIG_ID = '123456789012'.freeze
      OTHER_CONFIG_ID = 'G6679F4ZG3ASQXMGAGT9C8FBK4'.freeze
      
      it 'should be called with a valid configuration id and return a valid eGift json: 1' do
        # VGQ4ZMS0X1JHZ7LAXQVGRT8QZ9: DIGITAL FRC 01A: APPROVED FIXED (BARCODE) - NL EUR 5.0
        # Config: SNPZWSWTQHWYCF4THKMPFK5ZH0
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
      
      it 'should be called with invalid amount and return 400 giftamount null: 1.1', :test => true do
        INVALID_AMOUNT_CONFIG_ID = 'PZF9A147MCQV49PD6MWHMZ1109'
        amount = nil
        reference = rand.to_s[2..13]
        client = BlackhawkApi::BlackhawkClient.new
        
        expect {
          client.generate_egift(VALID_CONFIG_ID, amount, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called with an invalid purchase id and return purchaserId null: 1.2' do
        amount = 5
        reference = rand.to_s[2..13]
        invalid_purchaser_id = '6A6GRHWP2GNW71S67W2AX41FS'
        gift_service = BlackhawkApi::GiftService.new
        
        request = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
          nil, nil, nil, amount, invalid_purchaser_id, nil, reference,
          nil, VALID_CONFIG_ID, nil, nil
        )
        expect {
          gift_service.generate request
        }.to raise_error(BlackhawkApi::ApiError)        
      end
      
      it 'should be called with null configuration id and return productConfigurationId.null: 1.3' do
        pending('Not possible yet due to argument validations')
        fail
        
        amount = 5
        reference = rand.to_s[2..13]
        client = BlackhawkApi::BlackhawkClient.new
        
        expect {
          client.generate_egift(nil, amount, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called with invalid configuration id and return 409 product not found: 1.4' do
        amount = 5
        reference = rand.to_s[2..13]
        client = BlackhawkApi::BlackhawkClient.new
        
        expect {
          client.generate_egift(INVALID_CONFIG_ID, amount, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called while not part of the clients configuration and return 409 product not in catalog: 1.5' do
        amount = 5
        reference = rand.to_s[2..13]
        client = BlackhawkApi::BlackhawkClient.new
        
        expect {
          client.generate_egift(OTHER_CONFIG_ID, amount, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called with invalid value and return 409 account creation failed: 1.6' do
        amount = -1
        reference = rand.to_s[2..13]
        client = BlackhawkApi::BlackhawkClient.new
        
        expect {
          client.generate_egift(VALID_CONFIG_ID, amount, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called when the service is unavailable and return Service Not Available / Bad Gateway: 1.8' do
        # 4ZQ8DP8PBNTNL7KH5ZRGYGV435: DIGITAL FRC 07: 502 ERROR (30 SEC T/O) - NL EUR 5.0
        # Config: 2KHHTTQ67ZMDL3CTKFL3Q563L6
        FRC_CONFIG = '2KHHTTQ67ZMDL3CTKFL3Q563L6' 
        gift_service = BlackhawkApi::GiftService.new
        amount = 5
        ref = rand.to_s[2..13]

        request = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
          nil, nil, nil, amount, nil, nil, ref,
          nil, FRC_CONFIG, nil, nil)
        
        expect { gift_service.generate request }.to raise_error { | error |
        }
      end
      
      it 'should be called when Blast is down and return timeout with the processor: 1.9' do
        skip
      end
      
      it 'should be called when product is not available and return product inventory is not available: 1.10', :inventory => true do
        # 7Y77APSD5Q52FVQAYCXN45SLZF: DIGITAL FRC 02: 409 CARD NOT FOUND - NL EUR 5.0
        # Config: SG49BRMV9W0PV3J1NQLG8NKQ2A
        FRC06_CONFIG = 'SG49BRMV9W0PV3J1NQLG8NKQ2A'.freeze
        # WQ73AH42TYWVJ2CQM82S91KFC6
        gift_service = BlackhawkApi::GiftService.new
        amount = 5
        ref = rand.to_s[2..13]

        request = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
          nil, nil, nil, amount, nil, nil, ref,
          nil, FRC06_CONFIG, nil, nil)
        
        expect { gift_service.generate request }.to raise_error { | error |
          expect(error.http_code).to eq(409)
          expect(error.error_code).to eq('egiftprocessing.account.creation.failed.account.inventory.unavailable')
        }
      end
    end
    
    describe 'Void eGift', :void_egift => true do
      it 'should be called with a valid egift id and return a valid eGift json: 3' do
        client = BlackhawkApi::BlackhawkClient.new
        reference = rand.to_s[2..13]
        amount = 5
        egift = client.generate_egift('8MJAB7C7P6NZ7YAH8P6N7W2NTL', amount, reference)
        egift_id = BlackhawkApi::IdentityExtractor.to_identity(egift.information.entity_id)
        
        result = client.void_egift(egift_id, reference)
        
        expect(result.code).to eq(200)
        expect(result.information).not_to eq(nil)
        expect(result.information.gift_amount).to eq(amount)
        expect(result.information.product_configuration_id).to eq(VALID_CONFIG_ID)
        expect(result.information.status).to eq("ACTIVATED")
        expect(result.information.suspended).to eq(false)
      end
      
      it 'should be called with an invalid egift id and return egift not found: 3.1' do
        client = BlackhawkApi::BlackhawkClient.new
        reference = rand.to_s[2..13]
        amount = 5
        INVALID_EGIFT_ID = '00100001000000100001010111'
        egift = client.generate_egift('8MJAB7C7P6NZ7YAH8P6N7W2NTL', amount, reference)
        
        expect {
          client.void_egift(INVALID_EGIFT_ID, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called when eGift is already voided OR underlying account is already closed and return egift already voided: 3.2' do
        client = BlackhawkApi::BlackhawkClient.new
        reference = rand.to_s[2..13]
        amount = 5

        egift = client.generate_egift('8MJAB7C7P6NZ7YAH8P6N7W2NTL', amount, reference)
        id = BlackhawkApi::IdentityExtractor.to_identity(egift.information.entity_id)
        # Perform initial void
        client.void_egift(id, reference)
        
        expect {
          client.void_egift(id, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
    end
    
    describe 'eGift Processing' do
      it 'should be called when the service is unavailable and return Service Not Available or Bad Gateway: 4' do
        # 4ZQ8DP8PBNTNL7KH5ZRGYGV435: DIGITAL FRC 07: 502 ERROR (30 SEC T/O) - NL EUR 5.0
        # Config: 2KHHTTQ67ZMDL3CTKFL3Q563L6
        client = BlackhawkApi::BlackhawkClient.new
        reference = rand.to_s[2..13]
        amount = 5

        expect {
          client.generate_egift('2KHHTTQ67ZMDL3CTKFL3Q563L6', amount, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
      
      it 'should be called with a timeout and return ws.provider.timeout: 4.1' do
        # BAP0S82F351Q628MSKXTZ0R726: DIGITAL FRC 08: 504 GATEWAY TIMEOUT - NL EUR 5.0
        # Config: 73NYTS7APGW5GT5BMM4RZC1PJ9
        client = BlackhawkApi::BlackhawkClient.new
        reference = rand.to_s[2..13]
        amount = 5

        expect {
          client.generate_egift('73NYTS7APGW5GT5BMM4RZC1PJ9', amount, reference)
        }.to raise_error(BlackhawkApi::ApiError)
      end
    end
  end
end