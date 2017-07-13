require 'spec_helper'

describe BlackhawkApi::BlackhawkClient do
  let(:config_json) { YAML.load(File.open('./config/bhn_config.certification.yml')).to_json }
  let(:config) { JSON.parse(config_json, object_class: OpenStruct) }
  let(:base_url) { 'https://api.certification.blackhawknetwork.com' }
  let(:product_id) { 'VGQ4ZMS0X1JHZ7LAXQVGRT8QZ9' }
  let(:product_config_id) { '8MJAB7C7P6NZ7YAH8P6N7W2NTL' }
  let(:productline_id) { 'FY9GWP49A84S6HKMFXHQ76HDCD' }
  let(:catalog_id) { 'R7N2G9WKC9CKHJ5FSS37T41RMH' }
  let(:request_id) { '635346958583' }

  subject { described_class.new(config) }

  before do
    allow(config).to receive(:resourcelocation).and_return(base_url: base_url)
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

  describe '#read_product_catalogs' do
    it 'returns product catalogs from the blackhawk API successfully' do
      expect(subject.read_product_catalogs.code).to eq 200
    end
  end

  describe '#read_catalog' do
    it 'returns catalog from the blackhawk API successfully' do
      expect(subject.read_catalog(catalog_id).code).to eq 200
    end
  end

  describe '#read_product' do
    it 'returns product details from the blackhawk API successfully' do
      expect(subject.read_product(product_id).code).to eq 200
    end
  end

  describe '#read_productline' do
    it 'returns product line from the blackhawk API successfully' do
      expect(subject.read_productline(productline_id).code).to eq 200
    end
  end

  describe '#read_account' do
    it 'returns account details from the blackhawk API successfully' do
      expect(subject.read_account('J5FZ4KAC98LALH5WC9GHA47DDC').code).to eq 200
    end
  end

  describe '#generate_egift' do
    let(:generated_egift) { subject.generate_egift(product_config_id, 5, nil) }

    it 'generates a EGift successfully' do
      expect(generated_egift.code).to eq 200
    end

    it 'the amount is valid' do
      expect(generated_egift.information.gift_amount).to eq 5
    end

    it 'the status is activated' do
      expect(generated_egift.information.status).to eq 'ACTIVATED'
    end

    it 'the product id is correct' do
      expect(generated_egift.information.product_configuration_id).to eq product_config_id
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
