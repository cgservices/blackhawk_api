require 'spec_helper'

describe BlackhawkApi do
  it 'has a version number' do
    expect(BlackhawkApi::VERSION).not_to be nil
  end
  
  xit 'should add all required request headers for idempotency support' do
    # Request Headers
    # ====
    # requestorId
    # requestId
    # previousAttempts
    expect(false).to eq(true)
  end
  
  describe 'Accounts' do
    xit 'should read activation number' do
      # This operation uses an accountId to retrieve account information.
      # GET: https://api.blackhawknetwork.com/accountProcessing/v1/readAccount?accountId={accountId}
      
      # Fails: 400 - AccountID is null
      #  409 - Account does not exist.
      expect(false).to eq(true)
    end
  end
  
  describe 'Transactions' do
  end
  
  describe 'Giftcards' do
    xit 'should generate new gift cards' do
      # This operation generates an eGift for a product configuration.
      # POST: https://api.blackhawknetwork.com/eGiftProcessing/v1/generateEGift
      
      expect(false).to eq(true)
    end
  end    
end
