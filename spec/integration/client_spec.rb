require 'spec_helper'
require 'pry'

HttpLog.options[:logger]        = Logger.new($stdout)
HttpLog.options[:severity]      = Logger::Severity::INFO
HttpLog.options[:log_connect]   = true
HttpLog.options[:log_request]   = true
HttpLog.options[:log_headers]   = true
HttpLog.options[:log_data]      = true
HttpLog.options[:log_status]    = true
HttpLog.options[:log_response]  = true
HttpLog.options[:log_benchmark] = true

describe BlackhawkApi do
  describe 'BlackhawkClient' do
    xit 'should be able to read catalogs' do
      # Arrange
      client = BlackhawkApi::BlackhawkClient.new
      # Act
      result = client.read_catalogs
      # Assert
      expect(result).not_to eq(nil)
    end
    
    
    it 'should be able to read product details' do
      # Arrange
      product_id = 'VGQ4ZMS0X1JHZ7LAXQVGRT8QZ9'.freeze
      client = BlackhawkApi::BlackhawkClient.new
      # Act
      result = client.read_product product_id
      # Assert
      expect(result).not_to eq(nil)
    end
    
    
    xit 'should be able to generate a new egift' do
      # Arrange
      product_config_id = '8MJAB7C7P6NZ7YAH8P6N7W2NTL'.freeze
      client = BlackhawkApi::BlackhawkClient.new
      amount = 5
      reference = rand.to_s[2..13]
      # Act
      result = client.generate_egift product_config_id, amount, reference
      # Assert
      expect(result).not_to eq(nil)
    end
    
    
    xit 'should be able to void a generated egift' do
      # Arrange
      product_config_id = '8MJAB7C7P6NZ7YAH8P6N7W2NTL'.freeze
      client = BlackhawkApi::BlackhawkClient.new
      amount = 5
      reference = rand.to_s[2..13]
      
      egift_response = client.generate_egift product_config_id, amount, reference
      request_id = ''
      binding.pry
      egift_id = BlackhawkApi::IdentityExtractor.to_identity(egift_response.information.entity_id).to_s
      # Act
      result = client.void_egift request_id, egift_id, reference
      # Assert
      expect(result).not_to eq(nil)
    end
    
    
    xit 'should be able to reverse a generated egift' do
      # Arrange
      product_config_id = '8MJAB7C7P6NZ7YAH8P6N7W2NTL'.freeze
      client = BlackhawkApi::BlackhawkClient.new
      amount = 5
      reference = rand.to_s[2..13]
      
      egift_response = client.generate_egift product_config_id, amount, reference
      # request_id = egift_response.request_id
      request_id = ''
      binding.pry
      # Act
      result = client.reverse_egift request_id
      # Assert
      expect(result).not_to eq(nil)
    end
    
    
    it 'should be able to reverse a voided egift' do
      # Arrange
      product_config_id = '8MJAB7C7P6NZ7YAH8P6N7W2NTL'.freeze
      client = BlackhawkApi::BlackhawkClient.new
      amount = 5
      reference = rand.to_s[2..13]
      
      egift_response = client.generate_egift product_config_id, amount, reference
      # request_id = egift_response.request_id
      request_id = ''
      binding.pry
      egift_id = BlackhawkApi::IdentityExtractor.to_identity(egift_response.information.entity_id).to_s
      client.void_egift request_id, egift_id, reference
      # Act
      result = client.reverse_egift request_id
      # Assert
      expect(result).not_to eq(nil)
    end
  end
end