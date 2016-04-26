require 'spec_helper'
require 'blackhawk_api/client/helpers/identity_extractor'
require 'pry'

describe BlackhawkApi do
  describe 'Read Products' do
    xit 'should trigger validations' do
      gift_service = BlackhawkApi::GiftService.new
      amount = 0
      ref = rand.to_s[2..12]
      
      request = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
        nil, nil, nil, amount, nil, nil, ref,
        nil, VALID_CONFIG_ID, nil, nil)

      expect { gift_service.generate request }.to raise_error( Veto::InvalidEntity )
    end
  end
end