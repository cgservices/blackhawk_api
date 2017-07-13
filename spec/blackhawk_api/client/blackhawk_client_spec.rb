require 'spec_helper'

describe BlackhawkApi::BlackhawkClient do
  subject { described_class.new(Struct.new(nil)) }

  let(:response) { HTTPI::Response.new(200, {}, response_body) }
  let(:response_body) { { summary: {}, results: {} }.to_json }

  before do
    allow(subject).to receive(:get).and_return response
    allow(subject).to receive(:post).and_return response
    allow_any_instance_of(BlackhawkApi::RESTResource).to receive(:setup_request).and_return(BlackhawkApi::Request.new('http://www.test.com'))
    allow(BlackhawkApi::ProductDetails).to receive(:new)
    allow(BlackhawkApi::ProductLineDetails).to receive(:new)
    allow(BlackhawkApi::ProductCatalogSummary).to receive(:new)
    allow(BlackhawkApi::ProductCatalogDetails).to receive(:new)
  end

  describe '#read_product_catalogs' do
    it 'returns a product catalogs response object' do
      expect(subject.read_product_catalogs).to be_a BlackhawkApi::Responses::ProductCatalogsResponse
    end
  end

  describe '#read_catalog' do
    it 'returns a product catalogs response object' do
      expect(subject.read_catalog('1')).to be_a BlackhawkApi::Responses::ProductCatalogDetailsResponse
    end
  end

  describe '#read_productline' do
    it 'returns a product catalogs response object' do
      expect(subject.read_productline('1')).to be_a BlackhawkApi::Responses::ProductLineDetailsResponse
    end
  end

  describe '#read_product' do
    it 'returns a product response object' do
      expect(subject.read_product('1')).to be_a BlackhawkApi::Responses::ProductDetailsResponse
    end
  end

  describe '#read_account' do
    it 'returns a account details response object' do
      expect(subject.read_account('1')).to be_a BlackhawkApi::Responses::AccountDetailsResponse
    end
  end

  describe '#generate_egift' do
    it 'returns a GiftDetailsResponse object' do
      expect(subject.generate_egift('1', 5, nil)).to be_a BlackhawkApi::Responses::GiftDetailsResponse
    end
  end

  describe '#reverse_egift' do
    it 'returns a AccountTransactionResponse object' do
      expect(subject.reverse_egift(nil)).to be_a BlackhawkApi::Responses::AccountTransactionResponse
    end
  end

  describe '#void_egift' do
    it 'returns a GiftDetailsResponse object' do
      expect(subject.void_egift(1, nil)).to be_a BlackhawkApi::Responses::GiftDetailsResponse
    end
  end
end
