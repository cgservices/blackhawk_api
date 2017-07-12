require 'spec_helper'

describe BlackhawkApi::BlackhawkClient do
  let(:config_json) { YAML.load(File.open('./config/bhn_config.certification.yml')).to_json }
  let(:config) { JSON.parse(config_json, object_class: OpenStruct) }
  let(:base_url) { 'https://api.certification.blackhawknetwork.com' }
  let(:product_id) { 'VGQ4ZMS0X1JHZ7LAXQVGRT8QZ9' }
  let(:product_config_id) { '8MJAB7C7P6NZ7YAH8P6N7W2NTL' }
  let(:request_id) { '635346958583' }

  subject { described_class.new(config) }

  before do
    allow(config).to receive(:resourcelocation).and_return({ base_url: base_url })
    allow(config).to receive(:identifiers).and_return(config.merchants.mobiletopup_uk.identifiers)
    allow(config).to receive(:certificate).and_return(config.countries.uk)
  end

  describe '#initialize' do
    it 'should be threadsafe' do
      config1 = Struct.new(nil)
      config2 = Struct.new(nil)
      client1 = BlackhawkApi::BlackhawkClient.new(config1)
      client2 = BlackhawkApi::BlackhawkClient.new(config2)
      expect(client1.instance_variable_get(:@config)).to eq config1
      expect(client2.instance_variable_get(:@config)).to eq config2
      expect(client1.instance_variable_get(:@config)).not_to eq client2.instance_variable_get(:@config)
    end
  end

  describe '#read_product' do
    it 'returns product details from the blackhawk API successfully' do
      expect(subject.read_product(product_id).code).to eq 200
    end
  end

  describe '#read_account' do
    it 'returns account details from the blackhawk API successfully' do
      expect(subject.read_account('J5FZ4KAC98LALH5WC9GHA47DDC').code).to eq 200
    end
  end

  describe '#generate_egift' do
    it 'generates a EGift successfully' do
      expect(subject.generate_egift(product_config_id, 5, rand.to_s[2..13]).code).to eq 200
    end
  end

  describe '#reverse_egift' do
    xit 'reverses a EGift successfully' do
      expect(subject.reverse_egift(request_id).code).to eq 200
    end
  end

  describe '#void_egift' do
    before do
      @reference = rand.to_s[2..13]
      egift_response = subject.generate_egift(product_config_id, 5, @reference)
      @egift_id = BlackhawkApi::IdentityExtractor.to_identity(egift_response.information.entity_id).to_s
    end

    xit 'voids a EGift successfully' do
      expect(subject.void_egift(@egift_id, @reference).code).to eq 200
    end
  end
end
