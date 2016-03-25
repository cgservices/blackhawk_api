require 'spec_helper'
require 'pry'

describe BlackhawkApi do
  TEST_PRODUCTLINE_ID = 'HGX7DA56YAZQK69K3FJNHT4G70'
  
  describe 'ProductLine Application Service' do
    context 'Find' do
      # This operation should read product detail information based on a specified product dentifier.
      # GET: https://api.blackhawknetwork.com/productManagement/v1/product/{productId}
        
      # Fails: 404 - NonExistent
      it 'should read single product details' do
        # Arrange
        sut = BlackhawkApi::ProductLineService.new
        # Act
        response = sut.find TEST_PRODUCTLINE_ID
        # Assert
        expect(response).not_to eq(nil)
      end
    end
    
    context 'Find By Brand' do
      context 'with invalid identity' do
        INVALID_BRAND_ID = '123456789123456789123456790123456789'
        EMPTY_BRAND_ID = ''
        
        it 'should raise ArgumentError on no identity' do
          # Arrange 
          brand = EMPTY_BRAND_ID
          # Act / Assert
          expect { BlackhawkApi::FindProductLinesByBrandRequest.new(brand) }.to raise_error(ArgumentError)
        end
        
        it 'should raise ArgumentError on invalid identity' do
          # Arrange 
          brand = INVALID_BRAND_ID
          # Act / Assert
          expect { BlackhawkApi::FindProductLinesByBrandRequest.new(brand) }.to raise_error(ArgumentError)
        end
      end
      
      it 'should show product summaries' do
        # Arrange
        VALID_BRAND_ID = 'TQVGSJAH2DL4G8BSR4J9M7HJVH'
        brand = VALID_BRAND_ID
        sut = BlackhawkApi::ProductLineService.new
        request = BlackhawkApi::FindProductLinesByBrandRequest.new(brand)
        # Act
        response = sut.find_summaries_by_brand request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
    
    context 'Find By IDs' do
      it 'should read product summaries' do
        # Arrange
        sut = BlackhawkApi::ProductLineService.new
        request = BlackhawkApi::FindProductLinesByIdsRequest.new([TEST_PRODUCTLINE_ID])
        # Act
        response = sut.find_summaries_by_ids request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
  end
end
