require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  # Data class for product catalog details
  class ProductCatalogDetails
    attr_reader :creator_id, :updater_id, :notes, :created_timestamp,
                :updated_timestamp, :product_urls, :description

    # Initializes a new product catalog details instance
    def initialize(details)
      @creator_id = BlackhawkIdentity.new(details.creatorId)
      @updater_id = BlackhawkIdentity.new(details.updaterId)
      @notes = details.notes
      @created_timestamp = details.created_timestamp
      @updated_timestamp = details.updated_timestamp
      @product_urls = details.productIds
      @description = details.description
    end
  end
end
