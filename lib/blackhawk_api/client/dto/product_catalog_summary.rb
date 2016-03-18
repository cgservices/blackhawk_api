module BlackhawkApi
  class ProductCatalogSummary
    attr_reader :version, :name
    
    def initialize(summary_data)
      @version = summary_data.version
      @name = summary_data.name
    end
  end
end