require 'spec_helper'

describe BlackhawkApi::BlackhawkClient do
  let(:config_json) { YAML.load(File.open('./config/bhn_config.certification.yml')).to_json }
  let(:config) { JSON.parse(config_json, object_class: OpenStruct) }
  let(:base_url) { 'https://api.certification.blackhawknetwork.com' }
  let(:product_id) { 'VGQ4ZMS0X1JHZ7LAXQVGRT8QZ9' }

  subject { described_class.new(config) }

  before do
    allow(config).to receive(:resourcelocation).and_return({ base_url: base_url })
    allow(config).to receive(:identifiers).and_return(config.merchants.mobiletopup_uk.identifiers)
    allow(config).to receive(:certificate).and_return(config.countries.uk)
  end

  describe '#read_product' do
    it 'returns product details from the blackhawk API' do
      expect(subject.read_product(product_id).code).to eq 200
    end
  end
end
