require 'spec_helper'
require 'json'

describe BlackhawkApi do
  TEST_PRODUCT_1 = '0K37ZQFK8WTNVJM1AVTKV1C3Z8'
  TEST_PRODUCT_2 = 'DQ9YZA4K56FABHF8JNYJH83FPW'
  TEST_CONFIGURATION_ID = 'TFS78H62M1VWXRAYY853G6CT14'
  
  describe 'Product Application Service' do
    context 'Find' do
      # This operation should read product detail information based on a specified product dentifier.
      # GET: https://api.blackhawknetwork.com/productManagement/v1/product/{productId}
        
      # Fails: 404 - NonExistent
      it 'should read single product details' do
        # Arrange
        sut = BlackhawkApi::ProductService.new
        # Act
        response = sut.find TEST_PRODUCT_1
        #  Assert
        expect(response).not_to eq(nil)
      end
    end
    
    context 'Find By Provisioning Type' do
      it 'should show product details by provisioning type' do
        # Arrange
        index = 0
        max_amount = 10
        sut = BlackhawkApi::ProductService.new
        request = BlackhawkApi::FindProductByProvisioningTypeRequest.new(
          :DIGITAL)
        
        # Act
        response = sut.find_by_provisioning_type request
        result = JSON.parse(response.raw_body, object_class: OpenStruct)
        
        # Assert
        expect(response).not_to eq(nil)
        expect(response.code).to eq(200)
        expect(result[:parameters]).not_to eq(nil)
        expect(result[:parameters][:first]).to eq(index)
        expect(result[:parameters][:ascending]).to eq(true)
        expect(result[:parameters][:maximum]).to eq(max_amount)
      end
      
      it 'should return an error with invalid provisioning types' do
        # Arrange
        index = 0
        max_amount = 10
        sut = BlackhawkApi::ProductService.new
        request = BlackhawkApi::FindProductByProvisioningTypeRequest.new(
          :invalid_product_type)
        
        # Act
        response = sut.find_by_provisioning_type request
        result = JSON.parse(response.raw_body, object_class: OpenStruct)
        
        # Assert
        expect(response).not_to eq(nil)
        expect(response.code).to eq(400)
        expect(result).not_to eq(nil)
        expect(result.errorCode).to eq('com.bhn.general.invalid.argument')
        expect(result.message).to eq('Illegal argument supplied in the request')
      end
    end
    
    context 'Find By Keyword' do
      it 'should read single product details' do
        # Arrange
        keyword = 'test'
        sut = BlackhawkApi::ProductService.new
        request = BlackhawkApi::FindProductByKeywordRequest.new(keyword)
        # Act
        response = sut.find_by_keyword request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
    
    context 'Find By ProductLine' do
      it 'should retrieve product details' do
        # Arrange
        index = 0
        max_amount = 15
        productline_id = 'SYKY6RM2AZ06DNYFW18CSM6MS0' 
        sut = BlackhawkApi::ProductService.new
        request = BlackhawkApi::FindProductByProductLineRequest.new(productline_id)
        # Act
        response = sut.find_by_productline request
        # result = JSON.parse(response.raw_body, object_class: OpenStruct)
        # Assert
        expect(response).not_to eq(nil)
        # expect(response.code).to eq(200)
        # expect(result[:parameters]).not_to eq(nil)
        # expect(result[:parameters][:first]).to eq(index)
        # expect(result[:parameters][:ascending]).to eq(true)
        # expect(result[:parameters][:maximum]).to eq(max_amount)        
      end
    end
    
    context 'Find By IDs' do
      it 'should read single product details' do
        # Arrange
        sut = BlackhawkApi::ProductService.new
        request = BlackhawkApi::FindProductsByIdsRequest.new([TEST_PRODUCT_1, TEST_PRODUCT_2])
        # Act
        response = sut.find_by_ids request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
    
    context 'Find By Configuration' do
      it 'should read single product details' do
        # Arrange
        sut = BlackhawkApi::ProductService.new
        request = BlackhawkApi::FindProductByConfigurationRequest.new(TEST_CONFIGURATION_ID)
        # Act
        response = sut.find_by_configuration request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
  end
end
