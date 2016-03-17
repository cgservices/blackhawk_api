require 'spec_helper'
require 'pry'

describe BlackhawkApi do
  TEST_GIFT_ID = ''
  TEST_ACCOUNT_ID = ''
  describe 'GiftCard Application Service' do
    context 'Find' do
      it 'should read single gift details' do
        # Arrange
        sut = BlackhawkApi::GiftService.new
        # Act
        response = sut.find TEST_GIFT_ID
        #  Assert
        expect(response).not_to eq(nil)
      end
    end
    
    context 'Generate' do
      it 'should generate a new giftcard' do
        # Arrange
        sut = BlackhawkApi::GiftService.new
        request = BlackhawkApi::GenerateGiftCardRequest.new
        # Act
        response = sut.generate request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
    
    context 'Find By Account Id' do
      it 'should show gift details for the current account' do
        # Arrange
        account_id = TEST_ACCOUNT_ID
        sut = BlackhawkApi::GiftService.new
        request = BlackhawkApi::FindGiftsByAccountRequest.new account_id
        # Act
        response = sut.find_by_account_id request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
    
    context 'Find By IDs' do
      it 'should show gift details for the given ids' do
        # Arrange
        gift_ids = TEST_GIFT_ID
        sut = BlackhawkApi::GiftService.new
        request = BlackhawkApi::FindGiftsByIdsRequest.new(gift_ids)
        binding.pry
        # Act
        response = sut.find_by_egift_ids request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
  end
end