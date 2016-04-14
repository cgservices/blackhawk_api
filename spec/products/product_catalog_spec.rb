require 'spec_helper'
require 'pry'

describe BlackhawkApi do
  TEST_CATALOG_ID = 'R7N2G9WKC9CKHJ5FSS37T41RMH'
  TEST_PRODUCT_ID = 'H0MM0RLHRZX2KD3S78G3YHHCA9'

  describe 'ProductCatalog Application Service' do
    context 'Query Catalogs' do
      it 'should query all product catalog summaries' do
        # Arrange
        sut = BlackhawkApi::CatalogService.new
        # Act
        response = sut.all
        # Assert
        expect(response.code).to eq(200)
        expect(response.results.length).to be(1)
      end
    end

    context 'Get Version' do
      it 'should read product catalog version' do
        # Arrange
        sut = BlackhawkApi::CatalogService.new
        catalog_id = TEST_CATALOG_ID

        # Act
        response = sut.get_version catalog_id

        # Assert
        expect(response).not_to eq(nil)
        expect(response.code).to eq(200)
      end

      it 'should fail for invalid catalog identity' do
        # Arrange
        sut = BlackhawkApi::CatalogService.new
        catalog_id = ''
        # Act
        response = sut.get_version catalog_id
        # Assert
        expect(response).not_to eq(nil)
        expect(response.code).to eq(404)
      end
    end

    context 'All' do
      it 'should query all product catalogs' do
        # This operation should query all product catalog summaries.
        # GET: https://api.blackhawknetwork.com/productCatalogManagement/v1/productCatalogs
        # Fails: 403 - Unauthorized

        # Arrange
        sut = BlackhawkApi::CatalogService.new
        request = BlackhawkApi::GetAllCatalogsRequest.new
        # Act
        response = sut.all request
        # Assert
        expect(response).not_to eq(nil)
      end
    end

    context 'Find' do
      # This operation should read product catalog information based on a specified product catalog identifier.
      # GET: https://api.blackhawknetwork.com/productCatalogManagement/v1/productCatalog/{catalogId}

      # Fails: 404 - NonExistent
      it 'reads the product catalog information' do
        # Arrange
        sut = BlackhawkApi::CatalogService.new
        # Act
        response = sut.find TEST_CATALOG_ID
        # Assert
        expect(response).not_to eq(nil)
      end
    end

    context 'Find By Product' do
      it 'should read product catalogs' do
        # Arrange
        sut = BlackhawkApi::CatalogService.new
        request = BlackhawkApi::FindCatalogsForProductRequest.new(TEST_PRODUCT_ID)
        # Act
        response = sut.find_product_catalogs_for_product request
        # Assert
        expect(response).not_to eq(nil)
      end
    end

    context 'Find By Name' do
      it 'should read product catalogs' do
        # Arrange
        sut = BlackhawkApi::CatalogService.new
        request = BlackhawkApi::FindCatalogsByNameRequest.new('Halfords eGift')
        # Act
        response = sut.find_by_name request
        # Assert
        expect(response).not_to eq(nil)
      end
    end

    context 'Find By IDs' do
      it 'should read product catalogs' do
        # Arrange
        sut = BlackhawkApi::CatalogService.new
        request = BlackhawkApi::FindCatalogsByIdsRequest.new([TEST_PRODUCT_ID])
        # Act
        response = sut.find_by_ids request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
  end
end
