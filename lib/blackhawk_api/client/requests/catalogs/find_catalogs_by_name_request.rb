require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  # Request object to find catalogs by name
  class FindCatalogsByNameRequest < PaginatedRequest
    attr_reader :name

    def initialize(name)
      @name = name
    end

    protected

    def name=(value)
      raise ArgumentError, 'Invalid name specified' if value.nil? || value.length == 0
      raise ArgumentError, 'No name specified' if value > 255
      @name = value
    end
  end
end
