require 'blackhawk_api/client/helpers/identity_extractor'

module BlackhawkApi
  # Data class for product catalog summary
  class ProductCatalogSummary
    attr_reader :entity_id, :entity_url, :version, :name

    # Initializes a new Product Catalog Summary instance.
    def initialize(summary_data)
      @entity_url = summary_data.entityId
      @entity_id = BlackhawkApi::IdentityExtractor.to_identity(summary_data.entityId).to_s
      @version = summary_data.version
      @name = summary_data.name
    end
  end
end
