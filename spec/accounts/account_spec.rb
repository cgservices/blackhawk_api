require 'spec_helper'
require 'pry'

describe BlackhawkApi do
  describe 'Accounts' do
    xit 'should read activation number' do
      # This operation uses an accountId to retrieve account information.
      # GET: https://api.blackhawknetwork.com/accountProcessing/v1/readAccount?accountId={accountId}
      
      # Fails: 400 - AccountID is null
      #  409 - Account does not exist.
      expect(false).to eq(true)
    end
    
    context 'Create' do
      it 'should create a new account' do
        # Arrange
        product_id = '' 
        amount = ''
        currency = ''
        transaction_time = ''
        reference_nr = ''
        store_nr = ''
        terminal_nr = ''
        base_transaction_id = ''
        
        sut = BlackhawkApi::AccountService.new
        request = BlackhawkApi::CreateAccountRequest.new(product_id, amount,
          currency, transaction_time, reference_nr, store_nr, terminal_nr, 
          base_transaction_id)
        # Act
        response = sut.create request
        result = JSON.parse(response.raw_body, object_class: OpenStruct)
        
        # Assert
        expect(response).not_to eq(nil)        
      end
    end
    
    context 'Find' do
      it 'should fail for invalid account identifiers' do
        # Arrange
        invalid_account_id = ''
        sut = BlackhawkApi::AccountService.new
        request = BlackhawkApi::FindAccountRequest.new(invalid_account_id)
        # Act
        response = sut.find request
        # Assert
        expect(response).not_to eq(nil)
      end
      
      it 'should find an account with a valid account identifier' do
        # Arrange
        valid_account_id = ''
        sut = BlackhawkApi::AccountService.new
        request = BlackhawkApi::FindAccountRequest.new(valid_account_id)
        # Act
        response = sut.find request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
    
    context 'Find with Balance' do
      it 'should fail for invalid account identifiers' do
        # Arrange
        invalid_account_id = ''
        sut = BlackhawkApi::AccountService.new
        request = BlackhawkApi::FindAccountRequest.new(invalid_account_id)
        # Act
        response = sut.find_with_balance request
        # Assert
        expect(response).not_to eq(nil)
      end
      
      it 'should find an account with a valid account identifier' do
        # Arrange
        valid_account_id = ''
        sut = BlackhawkApi::AccountService.new
        request = BlackhawkApi::FindAccountRequest.new(valid_account_id)
        # Act
        response = sut.find_with_balance request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
    
    context 'Lookup' do
      it 'should find an existing account' do
        # arrange
        account_number = ''
        product_line_id = ''
        account_type = ''
        sut = BlackhawkApi::AccountService.new
        request = BlackhawkApi::AccountLookupRequest.new(
          account_number, product_line_id, account_type)
        # Act
        response = sut.lookup request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
  end    
end