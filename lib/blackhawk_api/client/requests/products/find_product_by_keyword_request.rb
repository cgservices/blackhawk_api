require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  module Requests
    # Request object to find products by keyword.
    class FindProductByKeywordRequest < PaginatedRequest
      attr_reader :keyword, :exact_match, :case_sensitive

      def initialize(keyword, exact_match = true, case_sensitive = true)
        self.keyword = keyword
        @exact_match = exact_match
        @case_sensitive = case_sensitive
      end

      def keyword=(value)
        raise ArgumentError, 'No catalog name specified' if value.nil? || value.empty?
        raise ArgumentError, 'Catalog name specified too large (#{value})' if value.length > 255
        @keyword = value
      end
    end
  end
end