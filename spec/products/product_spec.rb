require 'spec_helper'
require 'json'

describe BlackhawkApi do
  TEST_PRODUCT_1 = 'H0MM0RLHRZX2KD3S78G3YHHCA9'.freeze
  TEST_PRODUCT_2 = 'DQ9YZA4K56FABHF8JNYJH83FPW'.freeze
  TEST_CONFIGURATION_ID = 'BAP0S82F351Q628MSKXTZ0R726'.freeze

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
      it 'should show product details by provisioning type as symbol' do
        # Arrange
        index = 0
        max_size = 10
        sut = BlackhawkApi::ProductService.new
        request = BlackhawkApi::FindProductByProvisioningTypeRequest.new(
          :DIGITAL)

        # Act
        response = sut.find_by_provisioning_type request, index, max_size
        result = JSON.parse(response.raw_body, object_class: OpenStruct)

        # Assert
        binding.pry
        expect(response).not_to eq(nil)
        expect(response.code).to eq(200)
        expect(result[:parameters]).not_to eq(nil)
        expect(result[:parameters][:first]).to eq(index)
        expect(result[:parameters][:ascending]).to eq(true)
        expect(result[:parameters][:maximum]).to eq(max_size)
      end

      it 'should show product details by provisioning type as string' do
        # Arrange
        index = 0
        max_size = 10
        sut = BlackhawkApi::ProductService.new
        request = BlackhawkApi::FindProductByProvisioningTypeRequest.new(
          'DIGITAL')

        # Act
        response = sut.find_by_provisioning_type request, index, max_size
        result = JSON.parse(response.raw_body, object_class: OpenStruct)

        # Assert
        binding.pry
        expect(response).not_to eq(nil)
        expect(response.code).to eq(200)
        expect(result[:parameters]).not_to eq(nil)
        expect(result[:parameters][:first]).to eq(index)
        expect(result[:parameters][:ascending]).to eq(true)
        expect(result[:parameters][:maximum]).to eq(max_size)
      end

      it 'should return an error with invalid provisioning types' do
        # Arrange
        invalid_param = :invalid_product_type
        # Act / Assert
        expect { BlackhawkApi::FindProductByProvisioningTypeRequest.new(invalid_param) }.to raise_error(ArgumentError)
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
