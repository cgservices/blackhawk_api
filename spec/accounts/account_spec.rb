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
  end    
end