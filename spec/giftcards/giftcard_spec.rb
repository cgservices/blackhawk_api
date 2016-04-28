require 'spec_helper'
require 'pry'

describe BlackhawkApi do
  TEST_GIFT_ID = ''.freeze
  TEST_ACCOUNT_ID = ''.freeze
  describe 'GiftCard Application Service' do
    context 'Find' do
      it 'should read single gift details' do
        # Arrange
        INVALID_GIFT_ID = '123456789654'.freeze
        sut = BlackhawkApi::GiftService.new
        # Act
        response = sut.find INVALID_GIFT_ID
        #  Assert
        expect(response).not_to eq(nil)
        expect(response.code).to be(400)
      end
    end

    context 'Generate' do
      # This operation generates an eGift for a product configuration.
      # POST: https://api.blackhawknetwork.com/eGiftProcessing/v1/generateEGift
      it 'should generate a new giftcard' do
        # Arrange
        amount = 5
        ref = rand.to_s[2..13]
        sut = BlackhawkApi::GiftService.new
        request = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
          nil, nil, nil, amount, nil, nil, nil, ref,
          nil, CONFIG_ID, nil, nil)
        
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
        request = BlackhawkApi::Requests::FindGiftsByAccountRequest.new account_id
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
        request = BlackhawkApi::Requests::FindGiftsByIdsRequest.new(gift_ids)
        # Act
        response = sut.find_by_egift_ids request
        # Assert
        expect(response).not_to eq(nil)
      end
    end
  end
end
