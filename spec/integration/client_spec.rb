require 'spec_helper'

HTTPI.log = true

describe BlackhawkApi do
  describe 'BlackhawkClient' do
    PRODUCT_ID = 'VGQ4ZMS0X1JHZ7LAXQVGRT8QZ9'.freeze
    PRODUCT_CONFIG_ID = '8MJAB7C7P6NZ7YAH8P6N7W2NTL'.freeze

    def generate_reference
      rand.to_s[2..13]
    end

    it 'should be able to read catalogs' do
      # Arrange
      client = BlackhawkApi::BlackhawkClient.new
      # Act
      result = client.read_catalogs
      # Assert
      expect(result).not_to eq(nil)
    end


    it 'should be able to read product details' do
      # Arrange
      client = BlackhawkApi::BlackhawkClient.new
      # Act
      result = client.read_product PRODUCT_ID
      # Assert
      expect(result).not_to eq(nil)
    end


    it 'should be able to generate a new egift' do
      # Arrange
      client = BlackhawkApi::BlackhawkClient.new
      amount = 5
      reference = generate_reference

      # Act
      result = client.generate_egift PRODUCT_CONFIG_ID, amount, reference
      # Assert
      expect(result).not_to eq(nil)
    end

    it 'should be able to view a generated egift' do
      # Arrange
      client = BlackhawkApi::BlackhawkClient.new
      amount = 5
      reference = generate_reference

      egift_response = client.generate_egift PRODUCT_CONFIG_ID, amount, reference
      account_id = BlackhawkApi::IdentityExtractor.to_identity(
        egift_response.information.account_id).to_s

      # Act
      result = client.read_account account_id
      # Assert
      expect(result).not_to eq(nil)
      expect(result.code).to eq(200)
      expect(result.information).not_to eq(nil)
      expect(result.information.balance).to eq(amount)
    end

    it 'should be able to lookup account transactions' do
      # Arrange
      client = BlackhawkApi::BlackhawkClient.new
      amount = 5
      reference = generate_reference

      egift_response = client.generate_egift PRODUCT_CONFIG_ID, amount, reference
      account_id = BlackhawkApi::IdentityExtractor.to_identity(
        egift_response.information.account_id).to_s

      # Act
      result = client.read_transactions_for_account account_id
      # Assert
      expect(result).not_to eq(nil)
      expect(result.code).to eq(200)
      expect(result.total).to eq(1)
      expect(result.results.length).to eq(result.total)
      expect(result.results[0].requested_amount).to eq(amount)
    end

    it 'should be able to lookup account transaction details' do
      # Arrange
      client = BlackhawkApi::BlackhawkClient.new
      amount = 5
      reference = generate_reference

      egift_response = client.generate_egift PRODUCT_CONFIG_ID, amount, reference
      account_id = BlackhawkApi::IdentityExtractor.to_identity(
        egift_response.information.account_id).to_s

      transaction_result = client.read_transactions_for_account account_id

      transaction_result.results.each do |transaction|
        transaction_id = BlackhawkApi::IdentityExtractor.to_identity(
            transaction.entity_id).to_s

        # Act
        result = client.read_transaction transaction_id
        # Assert
        expect(result).not_to eq(nil)
        expect(result.code).to eq(200)
      end
    end


    it 'should be able to void a generated egift' do
      # Arrange
      client = BlackhawkApi::BlackhawkClient.new
      amount = 5
      reference = generate_reference

      egift_response = client.generate_egift PRODUCT_CONFIG_ID, amount, reference
      egift_id = BlackhawkApi::IdentityExtractor.to_identity(
        egift_response.information.entity_id).to_s

      # Act
      reference = generate_reference
      result = client.void_egift egift_id, reference
      # Assert
      expect(result).not_to eq(nil)
    end


    it 'should be able to reverse a generated egift' do
      # Arrange
      client = BlackhawkApi::BlackhawkClient.new
      amount = 5
      reference = generate_reference

      egift_response = client.generate_egift PRODUCT_CONFIG_ID, amount, reference
      request_id = BlackhawkApi::IdentityExtractor.to_identity(
        egift_response.request_id).to_s

      # Act
      result = client.reverse_egift request_id
      # Assert
      expect(result).not_to eq(nil)
    end


    it 'should be able to reverse a voided egift' do
      # Arrange
      client = BlackhawkApi::BlackhawkClient.new
      amount = 5
      reference = generate_reference

      egift_response = client.generate_egift PRODUCT_CONFIG_ID, amount, reference
      egift_id = BlackhawkApi::IdentityExtractor.to_identity(
        egift_response.information.entity_id).to_s

      void_response = client.void_egift egift_id, reference
      request_id = BlackhawkApi::IdentityExtractor.to_identity(
        void_response.request_id).to_s

      # Act
      result = client.reverse_egift request_id
      # Assert
      expect(result).not_to eq(nil)
    end
  end
end
