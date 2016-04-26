require 'blackhawk_api/version'
require 'httpi'
require 'json'

module BlackhawkApi
  # Base class for BlackHawk requests.
  class Request < HTTPI::Request
    attr_accessor :page_size, :page_index, :sort_key

    # Creates a new Request object for the specified url.
    # @param url The url to create a request object for.
    # @return Returns a new request.
    def self.create(url)
      request = new(url)
      request
    end

    # Skips the amount of items given.
    # @param amount Skips this amount of items.
    # @return Returns the request with a modified QueryString. 
    def skip(amount)
      parsed = CGI.parse(query) rescue {}
      self.query = { first: amount }.merge(parsed)
      self
    end

    # Takes this amount of items from the resource url.
    # @param count The maximum number of items to retrieve from the API.
    # @return Returns the request with a modified QueryString.
    def take(count)
      parsed = CGI.parse(query) rescue {}
      self.query = { maximum: count }.merge(parsed)
      self
    end

    # Requests a sorted resultset from the resource url.
    # @param sortkey The name of the parameter to sort_key
    # @param ascending Determines if the returned dataset should be sorted ascending or descending.
    # @return Returns the request with a modified QueryString.
    def orderby(sortkey, ascending = true)
      parsed = CGI.parse(query) rescue {}
      self.query = { sortKey: sortkey, ascending: ascending }
                  .merge(parsed)
      self
    end

    # Paginates the request with the defaults on the request.
    # @param request The request object to take the index, size and sortkey parameters from.
    # @return Returns the request with a modified QueryString.
    def paginate(request)
      skip(request.page_index * request.page_size)
        .take(request.page_size)
        .orderby(request.sort_key)
    end

    protected

    def initialize(url)
      super(url)
    end
  end

  # Base class for pagination support for BlackHawk requests.
  class PaginatedRequest < Request
    def initialize(sort_key, page_index, page_size)
      super(sort_key, page_index, page_size)
    end
  end
end