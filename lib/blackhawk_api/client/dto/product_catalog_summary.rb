require 'pry'
require 'uri'

module BlackhawkApi
  class ProductCatalogSummary
    attr_reader :entity_id, :entity_url, :version, :name
    
    def initialize(summary_data)
      @entity_url = summary_data.entityId
      @entity_id = URI(summary_data.entityId).path.split('/').last
      @version = summary_data.version
      @name = summary_data.name
    end
  end
end