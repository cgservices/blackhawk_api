require 'spec_helper'

describe BlackhawkApi do
  it 'has a version number' do
    expect(BlackhawkApi::VERSION).not_to be nil
  end
  
  it 'should add all required request headers for idempotency support' do
    # Request Headers
    # ====
    # requestorId
    # requestId
    # previousAttempts
    expect(false).to eq(true)
  end
  
  describe 'Product Catalog' do
    it 'should query all product catalogs' do
      # This operation should query all product catalog summaries.
      # GET: https://api.blackhawknetwork.com/productCatalogManagement/v1/productCatalogs
      
      # Fails: 403 - Unauthorized
      expect(false).to eq(true)
    end

    it 'reads the product catalog information' do
      # This operation should read product catalog information based on a specified product catalog identifier.
      # GET: https://api.blackhawknetwork.com/productCatalogManagement/v1/productCatalog/{catalogId}
      
      # Fails: 404 - NonExistent
      expect(false).to eq(true)
    end
    
    it 'should read single product details' do
      # This operation should read product detail information based on a specified product dentifier.
      # GET: https://api.blackhawknetwork.com/productManagement/v1/product/{productId}
      
      # Fails: 404 - NonExistent
      expect(false).to eq(true)
    end
  end
  
  describe 'EGift Processing' do
    it 'should generate new gift cards' do
      # This operation generates an eGift for a product configuration.
      # POST: https://api.blackhawknetwork.com/eGiftProcessing/v1/generateEGift
    end
  end
    
  describe 'Account Processing' do
    it 'should read activation number' do
      # This operation uses an accountId to retrieve account information.
      # GET: https://api.blackhawknetwork.com/accountProcessing/v1/readAccount?accountId={accountId}
      
      # Fails: 400 - AccountID is null
      #  409 - Account does not exist.
    end
  end
end
