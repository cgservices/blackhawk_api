require 'spec_helper'
require 'logger'

describe BlackhawkApi do

  describe 'FRC01: Approved Variable -' do
    # WH7V1Z5584XM0XGZ7JS61C7FHW: DIGITAL FRC 01: APPROVED VARIABLE - NL EUR 5.0
    # Config: 8MJAB7C7P6NZ7YAH8P6N7W2NTL
    PRODUCT_ID = 'WH7V1Z5584XM0XGZ7JS61C7FHW'.freeze
    CONFIG_ID = '8MJAB7C7P6NZ7YAH8P6N7W2NTL'.freeze

    # 1. Select product
    # 2. Call generateEGift
    #  unique val for requestId
    #  set egift amount to giftAmount
    #  set productConfigurationId
    #  set retrievalReferenceNumber
    # 3. If 2 fails with no response:
    #  call generateEGift with the same parameters
    #  set previousAttempts to 1 and increment by 1
    #  if no response ..
    #   call reverseEGift
    #    set reversalEGiftRequestId to requestId from 2
    #   if reverseEGift does not respond, call Blackhawk Service
    # 4. If 2 fails with 504 or 502
    #  Call reverse EGift mapping the request ID from 2
    #   if reverse EGift does not respond, call Blackhawk Service
    # 5. Present EGift
    it 'should create a gift card' do
      gift_service = BlackhawkApi::GiftService.new
      amount = 5
      ref = rand.to_s[2..13]

      request = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
        nil, nil, nil, amount, nil, nil, ref,
        nil, CONFIG_ID, nil, nil)
      
      begin
        response = gift_service.generate request
        raise 'invalid response' if response == nil || response.code != 200
      rescue => e
        puts "Reference used: #{ref}"
        fail e
      end
    end
  end
  
  describe 'FRC01A: Approved Fixed -' do
    # VGQ4ZMS0X1JHZ7LAXQVGRT8QZ9: DIGITAL FRC 01A: APPROVED FIXED (BARCODE) - NL EUR 5.0
    # Brand: Digital Product Testing
    # Config: SNPZWSWTQHWYCF4THKMPFK5ZH0
    FRC1A_VALID_PRODUCT_ID = 'VGQ4ZMS0X1JHZ7LAXQVGRT8QZ9'.freeze
    VALID_CONFIG_ID = 'SNPZWSWTQHWYCF4THKMPFK5ZH0'.freeze
    
    xit 'should create a gift card' do
      gift_service = BlackhawkApi::GiftService.new
      amount = 5
      ref = rand.to_s[2..13]
      
      step_2 = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
        nil, nil, nil, amount, nil, nil, ref,
        nil, VALID_CONFIG_ID, nil, nil)
      
      begin
        response = gift_service.generate step_2
        raise 'invalid response' if response == nil || response.code != 200
      rescue
        puts "Reference used: #{ref}"
        step_2.increment_attempt
        
        begin
          response = gift_service.generate step_2
          raise 'invalid response' if response == nil || response.code != 200
        rescue
          step_3 = BlackhawkApi::Requests::ReverseGiftCardRequest.new()
          response = gift_service.reverse_gift step_3
        end
      end
    end
  end
  
  describe 'FRC02: Card not Found -' do
    # 7Y77APSD5Q52FVQAYCXN45SLZF: DIGITAL FRC 02: 409 CARD NOT FOUND - NL EUR 5.0
    # Config: SG49BRMV9W0PV3J1NQLG8NKQ2A
    CONFIG_ID = 'SG49BRMV9W0PV3J1NQLG8NKQ2A'.freeze
    xit 'should not fulfill the transaction of the giftcard' do
      gift_service = BlackhawkApi::GiftService.new
      amount = 5
      ref = rand.to_s[2..13]

      step_2 = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
        nil, nil, nil, amount, nil, nil, ref,
        nil, CONFIG_ID, nil, nil)
      
      expect { gift_service.generate step_2 }.to raise_error { | error |
        expect(error.http_code).to eq(409)
        expect(error.error_code).to eq('egiftprocessing.account.creation.failed.card.not.found')
      }
    end
  end
  
  describe 'FRC03: General Decline -' do
    # SBGW7WWZG4WAHL66AYA72DXYJ4: DIGITAL FRC 03: GENERAL DECLINE - NL EUR 5.0
    # Config: WZZ1YZP1VJQRL4PWFKT0NZPKA5
    CONFIG_ID = 'WZZ1YZP1VJQRL4PWFKT0NZPKA5'.freeze
    xit 'should decline the giftcard' do
      gift_service = BlackhawkApi::GiftService.new
      amount = 5
      ref = rand.to_s[2..13]

      step_2 = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
        nil, nil, nil, amount, nil, nil, ref,
        nil, CONFIG_ID, nil, nil)
      
      expect { gift_service.generate step_2 }.to raise_error { | error |
        expect(error.http_code).to eq(409)
        expect(error.error_code).to eq('egiftprocessing.account.creation.failed.general.decline')
      }
    end
  end
  
  describe 'FRC04: Invalid Amount -' do
    # RLQGPFDZ4M4WZFF311L5YDZR5L: DIGITAL FRC 04: INVALID AMOUNT - NL EUR 5.0
    # Config: PZF9A147MCQV49PD6MWHMZ1109
    CONFIG_ID = 'PZF9A147MCQV49PD6MWHMZ1109'.freeze
    xit 'should decline the giftcard' do
      gift_service = BlackhawkApi::GiftService.new
      amount = 5
      ref = rand.to_s[2..13]

      step_2 = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
        nil, nil, nil, amount, nil, nil, ref,
        nil, CONFIG_ID, nil, nil)
      
      expect { gift_service.generate step_2 }.to raise_error { | error |
        expect(error.http_code).to eq(409)
        expect(error.error_code).to eq('egiftprocessing.account.creation.failed.invalid.amount')
      }
    end
  end
  
  describe 'FRC05: Invalid merchant -' do
    # SKSX3BHA3MSMSDDH6AV2WVLLGL: DIGITAL FRC 05: INVALID MERCHANT - NL EUR 5.0
    # Config: BH6TGXSBZQGPSLFSGD463JM7A0
    CONFIG_ID = 'BH6TGXSBZQGPSLFSGD463JM7A0'.freeze
    xit 'should decline the giftcard' do
      gift_service = BlackhawkApi::GiftService.new
      amount = 5
      ref = rand.to_s[2..13]

      request = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
        nil, nil, nil, amount, nil, nil, ref,
        nil, CONFIG_ID, nil, nil)
      
      expect { gift_service.generate request }.to raise_error { | error |
        expect(error.http_code).to eq(409)
        expect(error.error_code).to eq('egiftprocessing.account.creation.failed.invalid.merchant')
      }
    end
  end
  
  describe 'FRC06: Inventory Unavailable -' do
    # L18HD78M1JAWX3MTP18QZYATA6: DIGITAL FRC 06: INVENTORY UNAVAILABLE - NL EUR 5.0
    # Config: RVLSWRY63S63BTR2MY151ZSK0Q
    CONFIG_ID = 'RVLSWRY63S63BTR2MY151ZSK0Q'.freeze
    xit 'should decline the giftcard' do
      gift_service = BlackhawkApi::GiftService.new
      amount = 5
      ref = rand.to_s[2..13]

      request = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
        nil, nil, nil, amount, nil, nil, ref,
        nil, CONFIG_ID, nil, nil)
      
      expect { gift_service.generate request }.to raise_error { | error |
        expect(error.http_code).to eq(409)
        expect(error.error_code).to eq('egiftprocessing.account.creation.failed.account.inventory.unavailable')
      }
    end
  end

  describe 'FRC07: 502 - Error 30s Timeout -' do
    # 4ZQ8DP8PBNTNL7KH5ZRGYGV435: DIGITAL FRC 07: 502 ERROR (30 SEC T/O) - NL EUR 5.0
    # Config: 2KHHTTQ67ZMDL3CTKFL3Q563L6

    # 1. Select product
    # 2. Call generateEGift
    # 3. Reverse EGift
    VALID_PRODUCT_ID = '4ZQ8DP8PBNTNL7KH5ZRGYGV435'.freeze
    VALID_CONFIG_ID = '2KHHTTQ67ZMDL3CTKFL3Q563L6'.freeze
    xit 'should reverse a generated gift card' do
      gift_service = BlackhawkApi::GiftService.new
      amount = 5
      ref = rand.to_s[2..13]

      step_2 = BlackhawkApi::Requests::GenerateGiftCardRequest.new(
        nil, nil, nil, amount, nil, nil, ref,
        nil, VALID_CONFIG_ID, nil, nil)
      
      begin
        response = gift_service.generate step_2
        raise 'invalid response' if response == nil || response.code != 200
        
        step_3 = BlackhawkApi::Requests::ReverseGiftCardRequest.new(ref)
        
        response = gift_service.reverse step_3
        expect(response.code).to eq(200)
      rescue => e
        fail e
      ensure
        puts "Reference used: #{ref}"
      end
    end
   end
  
  describe 'FRC08: Gateway Timeout -' do
    # BAP0S82F351Q628MSKXTZ0R726: DIGITAL FRC 08: 504 GATEWAY TIMEOUT - NL EUR 5.0
    # Config: 73NYTS7APGW5GT5BMM4RZC1PJ9
  end
  
  describe 'FRC09: Already Redeemed -' do
    # Q4W282JC0XJ3R5NXQ39JHHBMB7: DIGITAL FRC 09: 200 ALREADY REDEEMED - NL EUR 5.0
    # Config: FV0XD6FA5PLAP6QAX78XA96JQA
  end
  
  describe 'FRC10: Card Expired -' do
    # XWQLVXLZ45ZLCRF8V8B7F12S63: DIGITAL FRC 10: 200 CARD EXPIRED - NL EUR 5.0
    # Config: RPL0NVBRPLDJZW3QZGALP1WZH5
  end
  
  describe 'FRC11: Card not Found -' do
    # 3N4ZTWZ1MMYQKJKNPCF8H7A4SB: DIGITAL FRC 11: 200 CARD NOT FOUND - NL EUR 5.0
    # Config: WQ73AH42TYWVJ2CQM82S91KFC6
  end
  
  describe 'FRC12: General Decline -' do
    # 7XZ0W4TLRZ5BWB8QGAZ1DQFGYL: DIGITAL FRC 12: 200 GENERAL DECLINE - NL EUR 5.0
    # Config: 2TYW51MMC7QZ3BQ42QLVCA9XGD
  end
  
  describe 'FRC13: Insufficient Funds -' do
    # R06W49MWMN8N1D3SSAQ39H0PVZ: DIGITAL FRC 13: 200 INSUFFICIENT FUNDS - NL EUR 5.0
    # Config: FXFWTD1JPNJCGPGD4B5KV0RJAT
  end
  
  describe 'FRC14: Invalid amount -' do
    # Y49C53D3N158R3QCZ9S57RYLKR: DIGITAL FRC 14: 200 INVALID AMOUNT - NL EUR 5.0
    # Config: V6MFLN5ST36XK4XTWC3ZFSFN9Y
  end
  
  describe 'FRC15: Invalid Exp date -' do
    # 4CKMCMK422MLAJN05SXR7781LL: DIGITAL FRC 15: 200 INVALID EXP DATE - NL EUR 5.0
    # Config: 2FAAHQ8DL4N284JHNSRZ7VZQ6D
  end
  
  describe 'FRC16: Invalid merchant -' do
    # QC9LH31JCNWYLHCVR7423WXKHC: DIGITAL FRC 16: 200 INVALID MERCHANT - NL EUR 5.0
    # Config: 6QRAJRXLVB92XHF6WSD6YGYGCH
  end
  
  describe 'FRC17: Invalid Transaction -' do
    # CRGWCQB16H7NM8HVYR49RGD8CL: DIGITAL FRC 17: 200 INVALID TRANSACTION - NL EUR 5.0
    # Config: 1AR8DGJHXWZG89QZQ4YSCM10FB
  end
  
  describe 'FRC18: SP Timeout -' do
    # QFGNGW6QN09V17D19X4AV2FH7F: DIGITAL FRC 18: 200 SP TIMEOUT - NL EUR 5.0
    # Config: 5A75VKSLRB5SSPNLV2H7X11M1C
  end
  
  describe 'FRC19: Unable to Process -' do
    # H0MM0RLHRZX2KD3S78G3YHHCA9: DIGITAL FRC 19: 200 UNABLE TO PROCESS - NL EUR 5.0
    # Config: Q495YN0GBWNC95Q1STQWNKFYL9
  end
  
  describe 'FRC20: 502 Proxy Error -' do
    # 04KS76YX2AQPSDXXR19XX7KY2D: DIGITAL FRC 20: 502  PROXY ERROR - NL EUR 5.0
    # Config: HRF39H7A91NTF6AK43B0YW6CT1
  end
end
