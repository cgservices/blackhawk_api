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
end
