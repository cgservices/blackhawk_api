require 'spec_helper'
require 'pry'

describe BlackhawkApi do
  describe 'Account Application Service' do
    context 'Create' do
      xit 'should create single account details' do
        # Arrange
        product_id = 'WH7V1Z5584XM0XGZ7JS61C7FHW'
        sut = BlackhawkApi::AccountService.new
        # Act
        response = sut.create
        #  Assert
        expect(response).not_to eq(nil)
        expect(response.code).to be(200)
      end
    end
    
    context 'Find' do
      it 'should return not found for invalid accounts' do
        # Arrange
        account_id = ''
        sut = BlackhawkApi::AccountService.new
        # Act
        response = sut.find account_id
        # ASSERT
        expect(response).not_to eq(nil)
        expect(response.code).to be(404)
      end
      
      it 'should retrieve account information' do
        # Arrange
        account_id = ''
        sut = BlackhawkApi::AccountService.new
        # Act
        response = sut.find account_id
        # Assert
        expect(response).not_to eq(nil)
        expect(response.code).to be(200)
      end
    end
    
    context 'Lookup' do
      it 'should return an account' do
        # Arrange
        account_number = ''
        product_line_id = ''
        account_type = ''
        sut = BlackhawkApi::AccountService.new
        # Act
        response = sut.lookup(account_number, product_line_id, account_type)
        # Assert
        expect(response).not_to eq(nil)
        expect(response.code).to be(200)
      end
    end
  end
end